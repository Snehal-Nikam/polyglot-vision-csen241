
resource "aws_lb" "polyglot-alb" {
    depends_on                                  = [aws_lb_target_group.backend-tg, aws_lb_target_group.backend-tg, aws_lb_target_group.backend-tg]
    name                                        = "polyglotvision-alb"
    desync_mitigation_mode                      = "defensive"
    drop_invalid_header_fields                  = false
    enable_cross_zone_load_balancing            = true
    enable_deletion_protection                  = false
    enable_http2                                = true
    enable_tls_version_and_cipher_suite_headers = false
    enable_waf_fail_open                        = false
    enable_xff_client_port                      = false
    idle_timeout                                = 60
    internal                                    = false
    ip_address_type                             = "ipv4"
    load_balancer_type                          = "application"
    preserve_host_header                        = false
    security_groups                             = [
        "sg-0a65177406bd319bc",
    ]
    #subnets                                     = [
    #    "subnet-0312f94b9d6f54145",
    #    "subnet-04fa228704b381244",
    #    "subnet-0b93cd56b47f20650",
    #    "subnet-0c9a7ad1a8241333f",
    #]
    xff_header_processing_mode                  = "append"

    subnet_mapping {
        subnet_id = "subnet-0312f94b9d6f54145"
    }
    subnet_mapping {
        subnet_id = "subnet-04fa228704b381244"
    }
    subnet_mapping {
        subnet_id = "subnet-0b93cd56b47f20650"
    }
    subnet_mapping {
        subnet_id = "subnet-0c9a7ad1a8241333f"
    }
}

resource "aws_lb_listener" "polyglot-alb-listener-443" {
    depends_on        = [aws_lb.polyglot-alb]
    certificate_arn   = "arn:aws:acm:us-west-2:696541562962:certificate/b469be32-6aaa-4973-8367-4ee9106f4ba9"
    load_balancer_arn = aws_lb.polyglot-alb.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

    default_action {
        order            = 1
        target_group_arn = aws_lb_target_group.frontend-tg.arn
        type             = "forward"
    }

    mutual_authentication {
        ignore_client_certificate_expiry = false
        mode                             = "off"
    }
}

resource "aws_lb_listener_rule" "https-backend-tg-rule-1" {
  listener_arn = aws_lb_listener.polyglot-alb-listener-443.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-tg.arn
  }

  condition {
    path_pattern {
      values = ["/send"]
    }
  }
}

resource "aws_lb_listener_rule" "https-backend-tg-rule-2" {
  listener_arn           = aws_lb_listener.polyglot-alb-listener-443.arn
  priority               = 2

  action {
    type                 = "forward"
    target_group_arn     = aws_lb_target_group.backend-tg.arn
  }

  condition {
    path_pattern {
      values             = ["/list"]
    }
  }
}


resource "aws_lb_listener_rule" "https-worker-tg-rule" {
  listener_arn           = aws_lb_listener.polyglot-alb-listener-443.arn
  priority               = 3

  action {
    type                 = "forward"
    target_group_arn     = aws_lb_target_group.worker-tg.arn
  }

  condition {
    path_pattern {
      values             = ["/video"]
    }
  }
}

resource "aws_lb_listener" "polyglot-alb-listener-80" {
    depends_on           = [aws_lb.polyglot-alb]
    load_balancer_arn    = aws_lb.polyglot-alb.arn
    port                 = 80
    protocol             = "HTTP"
    default_action {
        order            = 2
        target_group_arn = aws_lb_target_group.frontend-tg.arn
        type             = "forward"
    }
}

resource "aws_lb_listener_rule" "http-backend-tg-rule-1" {
  listener_arn = aws_lb_listener.polyglot-alb-listener-80.arn
  priority           = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-tg.arn
  }
  condition {
    path_pattern {
      values         = ["/send"]
    }
  }
}

resource "aws_lb_listener_rule" "http-backend-tg-rule-2" {
  listener_arn = aws_lb_listener.polyglot-alb-listener-80.arn
  priority           = 2
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-tg.arn
  }
  condition {
    path_pattern {
      values         = ["/list"]
    }
  }
}


resource "aws_lb_listener_rule" "http-worker-tg-rule" {
  listener_arn = aws_lb_listener.polyglot-alb-listener-80.arn
  priority           = 3
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.worker-tg.arn
  }
  condition {
    path_pattern {
      values         = ["/video"]
    }
  }
}

resource "aws_route53_record" "app-polyglotvision-online" {
  depends_on = [aws_lb.polyglot-alb]
  zone_id = "Z01260761N1694YGQEOPD"
  name    = "app.polyglotvision.online"
  type    = "A"

  alias {
    name                   = aws_lb.polyglot-alb.dns_name
    zone_id                = aws_lb.polyglot-alb.zone_id
    evaluate_target_health = true
  }
}
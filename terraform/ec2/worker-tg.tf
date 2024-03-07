
resource "aws_lb_target_group" "worker-tg" {
    name                              = "worker-tg"
    deregistration_delay              = "30"
    ip_address_type                   = "ipv4"
    load_balancing_algorithm_type     = "round_robin"
    load_balancing_anomaly_mitigation = "off"
    load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
    port                              = 8081
    protocol                          = "HTTP"
    protocol_version                  = "HTTP1"
    slow_start                        = 0
    target_type                       = "instance"
    vpc_id                            = "vpc-0fab6d89be4a1f3ae"

    health_check {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
    }

    stickiness {
        cookie_duration = 86400
        enabled         = false
        type            = "lb_cookie"
    }

}

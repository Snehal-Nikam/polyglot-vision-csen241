
resource "aws_autoscaling_group" "polyglot-asg" {
    depends_on                = [aws_launch_template.ec2_fleet, aws_lb.polyglot-alb]
    name                      = "polyglotvision"
    max_size                  = 3
    min_size                  = 1
    health_check_grace_period = 60
    health_check_type         = "EC2"
    desired_capacity          = 1
    capacity_rebalance        = false
    default_cooldown          = 300
    default_instance_warmup   = 0
        vpc_zone_identifier       = [
        "subnet-0312f94b9d6f54145",
        "subnet-04fa228704b381244",
        "subnet-0b93cd56b47f20650",
        "subnet-0c9a7ad1a8241333f",
    ]
    instance_maintenance_policy {
        max_healthy_percentage = 110
        min_healthy_percentage = 100
    }

    launch_template {
        id      = aws_launch_template.ec2_fleet.id
        version = "$Latest"
    }

    target_group_arns         = [
        aws_lb_target_group.backend-tg.arn,
        aws_lb_target_group.frontend-tg.arn,
        aws_lb_target_group.worker-tg.arn
       ]
}


resource "aws_launch_template" "ec2_fleet"{
    name = "polyglot-server-launch"
    image_id = "ami-052c9ea013e6e3567"
    key_name = "dev-us-west-2"
    user_data = "${base64encode(data.template_file.init.rendered)}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-0b421944945dcc241",]
    iam_instance_profile {
    name = "s3-cogni"
    }

    block_device_mappings {
        device_name = "/dev/xvda"

        ebs {
          volume_size = "20"
        }
      }
}

data "template_file" "init" {
    template="${path.root}/ec2/userdata.tpl"
}




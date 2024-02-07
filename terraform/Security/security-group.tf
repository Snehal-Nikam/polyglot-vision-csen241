resource "aws_security_group" "lambda-subtitle-sg" {
  name        = "lambda-subtitle-sg"
  description = "Security Group for Lambda subtitle"
}

resource "aws_security_group" "subtitle-api-sg" {
  name        = "subtitle-api-sg"
  description = "Security Group for subtitle API"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.lambda-subtitle-sg.id]
  }
}

resource "aws_security_group_rule" "lambda-subtitle-sg-egress-rule" {
  type              = "egress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.lambda-subtitle-sg.id
  source_security_group_id = aws_security_group.subtitle-api-sg.id
}

resource "aws_security_group" "frontend-sg" {
  name        = "frontend-sg"
  description = "Security Group for Frontend"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend-sg" {
  name        = "backend-sg"
  description = "Security Group for Backend"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.frontend-sg.id]
  }
}
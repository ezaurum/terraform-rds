resource "aws_security_group" "db" {
  name        = "db servers"
  description = "Allow 3306 from same group"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    # self      = true
    cidr_blocks = [var.vpc_cidr_block]
    # security_groups = [aws_security_group.internal.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Stage        = var.stage
    Organization = var.organization
    Name         = "${var.organization}-db-${var.stage}"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  subnet_ids = aws_subnet.main[*].id
}

resource "aws_rds_cluster" "default" {
  cluster_identifier   = lower("${var.organization}-${var.stage}-cluster")
  engine               = "aurora-mysql"
  engine_version       = "5.7.mysql_aurora.2.11.0"
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  availability_zones   = aws_subnet.main[*].availability_zone

  database_name   = var.writer_db_name
  writer_username = var.writer_db_username
  writer_password = var.writer_db_password

  backup_retention_period = 5
  preferred_backup_window = "02:00-05:00"

  vpc_security_group_ids          = [aws_security_group.db.id]
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  skip_final_snapshot             = true

  tags = {
    Organization = var.organization
    Name         = "${var.organization} db cluster ${var.stage}"
    Stage        = var.stage
  }

  deletion_protection = true
}

resource "aws_rds_cluster_instance" "instance0" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id

  identifier     = lower("${var.organization}-${var.stage}-instance-0")
  instance_class = var.writer_instance_type

  engine         = aws_rds_cluster.default.engine
  engine_version = aws_rds_cluster.default.engine_version

  tags = {
    Organization = var.organization
    Name         = "${var.organization} instance 0 ${var.stage}"
    Stage        = var.stage
  }
}

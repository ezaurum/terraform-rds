resource "aws_ssm_parameter" "db_secret" {
  name        = "/${var.organization}/${var.stage}/database/password/writer"
  description = "${var.organization} ${var.stage} database writer password"
  type        = "SecureString"
  value       = var.writer_db_password

  tags = {
    Organization = var.organization
    Name         = "${var.organization} ${var.stage} db cluster secret"
    Stage        = var.stage
  }
}

resource "aws_ssm_parameter" "db_endpoint_writer" {
  name        = "/${var.organization}/${var.stage}/database/endpoint/writer"
  description = "${var.organization} ${var.stage} database writer endpoint"
  type        = "SecureString"
  value       = aws_rds_cluster.default.endpoint

  tags = {
    Organization = var.organization
    Name         = "${var.organization} ${var.stage} writer db endpoint"
    Stage        = var.stage
  }
}

resource "aws_ssm_parameter" "db_endpoint_reader" {
  name        = "/${var.organization}/${var.stage}/database/endpoint/reader"
  description = "${var.organization} ${var.stage} database reader endpoint"
  type        = "SecureString"
  value       = aws_rds_cluster.default.reader_endpoint

  tags = {
    Organization = var.organization
    Name         = "${var.organization} ${var.stage} reader db endpoint"
    Stage        = var.stage
  }
}

variable "writer_db_password" {
  type = string
}

variable "writer_db_name" {
  type = string
}

variable "writer_db_username" {
  type = string
}

variable "writer_instance_type" {
  # 스몰부터 가능
  type    = string
  default = "db.t3.small"
}

variable "reader_instance_type" {
  # 스몰부터 가능
  type    = string
  default = "db.t3.small"
}

variable "stage" {
  type = string
}

variable "organization" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

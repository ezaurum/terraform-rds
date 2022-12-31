data "aws_availability_zones" "available" {
}

resource "aws_subnet" "main" {
  vpc_id            = var.vpc_id
  count             = 3
  cidr_block        = "10.0.${100 + count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Organization = var.organization
    Name         = "${var.organization}-main_${count.index}-${var.stage}"
    Stage        = var.stage
  }
}

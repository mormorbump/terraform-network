
# 特にこだわりがなければ、VPCでは/16, subnetでは/24単位にするとわかりやすい。
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  # AWSのDNSサーバによる名前解決を有効化
  enable_dns_support = true
  # VPC内のリソースにpublicDNSホスト名を自動的に付与
  enable_dns_hostnames = true

  tags = {
    "Name" = "${var.name}-vpc"
  }

  # terraform上での削除を保護
  lifecycle {
    prevent_destroy       = false
  }
}

# VPCは隔離されたネットワークなので、VPCとインターネットで通信するための入り口であるインターネットゲートウェイを生成。
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    "Name" = "${var.name}-gw"
  }
}


##########################
### セキュリティグループ、web
resource "aws_security_group" "app" {
  name        = "${var.name}_web"
  description = "It is a security group on http of vpc"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.name}-web"
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "web" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app.id

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_security_group_rule" "https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app.id

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_security_group_rule" "all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app.id
}


#############################
### セキュリティグループdb
resource "aws_security_group" "db" {
  name        = "db_server"
  description = "It is a security group on db of vpc."
  vpc_id      = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.name}-db"
  }
}

resource "aws_security_group_rule" "db" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app.id
  security_group_id        = aws_security_group.db.id
}


#############################
### セキュリティグループredis

resource "aws_security_group" "redis" {
  name        = "redis_server"
  description = "It is a security group on redis of vpc."
  vpc_id      = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.name}-redis"
  }
}

resource "aws_security_group_rule" "redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app.id
  security_group_id        = aws_security_group.redis.id
}

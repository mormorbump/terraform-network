
output "aws_vpc" {
  value = aws_vpc.vpc
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.gw
}

output "aws_security_group_app" {
  value = aws_security_group.app
}

output "aws_security_group_db" {
  value = aws_security_group.db
}

output "aws_security_group_redis" {
  value = aws_security_group.redis
}

output "aws_security_group_rule_ssh" {
  value = aws_security_group_rule.ssh
}

output "aws_security_group_rule_web" {
  value = aws_security_group_rule.web
}

output "aws_security_group_rule_https" {
  value = aws_security_group_rule.https
}

output "aws_security_group_rule_all" {
  value = aws_security_group_rule.all
}
output "aws_security_group_rule_db" {
  value = aws_security_group_rule.db
}

output "aws_security_group_rule_redis" {
  value = aws_security_group_rule.redis
}

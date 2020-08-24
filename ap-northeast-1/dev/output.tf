output "aws_subnet_public_web" {
  value = aws_subnet.public_web
}

output "aws_subnet_public_https" {
  value = aws_subnet.public_https
}

output "aws_subnet_redash" {
  value = aws_subnet.redash
}

output "aws_subnet_front" {
  value = aws_subnet.front
}

output "aws_elasticache_subnet_group" {
  value = aws_elasticache_subnet_group.subnet
}

output "aws_db_subnet_group" {
  value = aws_db_subnet_group.main
}
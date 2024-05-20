output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "rds_security_group_id" {
  value       = aws_security_group.rds_sg.id
  description = "The ID of the RDS security group"
}

output "docdb_endpoint" {
  value = aws_docdb_cluster.mongo_cluster.endpoint
}

output "docdb_port" {
  value = aws_docdb_cluster.mongo_cluster.port
}
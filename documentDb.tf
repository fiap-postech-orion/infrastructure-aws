resource "aws_docdb_cluster" "mongo_cluster" {
  cluster_identifier  = "my-docdb-cluster"
  master_username     = "orion-user"
  master_password     = "orion-password"
  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.rds_public_subnet_group.name
  depends_on           = [aws_db_subnet_group.rds_public_subnet_group]
}

resource "aws_docdb_cluster_instance" "mongo_instance" {
  count              = 1
  identifier         = "my-docdb-cluster-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.mongo_cluster.id
  instance_class     = "db.r5.large"
}

resource "aws_security_group" "docdb_sg" {
  name_prefix = "docdb-sg-"

  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
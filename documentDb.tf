resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_db_subnet_group" "docdb_subnet_group" {
  name       = "my-docdb-subnet-group"
  subnet_ids = [aws_subnet.public.id]
}

resource "aws_security_group" "docdb_sg" {
  name        = "docdb-public-access-sg"
  description = "Allows access to DocumentDB from anywhere"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_docdb_cluster" "mongo_cluster" {
  cluster_identifier     = "my-docdb-cluster"
  engine                 = "docdb"
  master_username        = "foo"
  master_password        = "mustbeeightchars"
  db_subnet_group_name   = aws_db_subnet_group.docdb_subnet_group.name
  vpc_security_group_ids = [aws_security_group.docdb_sg.id]
  skip_final_snapshot    = false
}

resource "aws_docdb_cluster_instance" "mongo_instance" {
  count              = 1
  identifier         = "my-docdb-cluster-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.mongo_cluster.id
  instance_class     = "db.r5.large"
}

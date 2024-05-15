resource "aws_security_group" "rds_sg" {
  name        = "rds-public-access-sg"
  description = "Permite acesso ao RDS de qualquer lugar"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PublicRDSAccess"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "meu-rds-subnet-group"
  description = "Meu grupo de subnets do RDS"
  subnet_ids  = module.vpc.private_subnets

  tags = {
    Name = "meu-rds-subnet-group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage = 10
  db_name           = "postgres"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  username          = "postgres"
  password          = "password"

  multi_az            = false
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  publicly_accessible    = true

  tags = {
    Name = "MeuRDSPostgres"
  }
}
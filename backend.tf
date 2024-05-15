terraform {
  backend "s3" {
    bucket = "techchallenge-terraform"
    key    = "estado/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  backend "s3" {
    bucket = "orion-techchallenge"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_ecr_repository" "ecr-techchallenge" {
  name = "techchallenge-eks"
  force_delete =  true

  image_scanning_configuration {
    scan_on_push = true
  }
}

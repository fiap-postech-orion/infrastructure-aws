resource "aws_ecr_repository" "ecr-techchallenge" {
  name = "techchallenge-eks"

  image_scanning_configuration {
    scan_on_push = true
  }
}

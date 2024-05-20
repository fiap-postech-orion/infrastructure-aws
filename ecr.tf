resource "aws_ecr_repository" "cliente-api" {
  name         = "cliente-api-repository"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "pagamento-api" {
  name         = "pagamento-api-repository"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "pedido-api" {
  name         = "pedido-api-repository"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "producao-api" {
  name         = "producao-api-repository"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "produto-api" {
  name         = "produto-api-repository"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}
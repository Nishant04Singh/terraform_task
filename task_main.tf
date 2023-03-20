variable "use_case" {
  type = map(string)
  default = {
    "use_case_count" = "allowed"
    "dynamic_use_case" = "not_allowed"
  }
}

resource "aws_iam_role" "nishanteste_role" {
  name = "nishanteste_role"
  #namespace = var.namespace
  # assume_role_policy = jsonencode({
  #   Version = "2012-10-17"
  #   Statement = [
  #     {
  #       Effect = "Allow"
  #       Principal = {
  #         Service = "ec2.amazonaws.com"
  #       }
  #       Action = "sts:AssumeRole"
  #     }
  #   ]
  # })

  for_each = var.use_case

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:PrincipalTag/UseCase" = each.key
          }
        }
      }
    ]
  })

  # depends_on = [
  #   namespace.compiler
  # ]
}
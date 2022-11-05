#cria uma poilitica de permissoes para a ec2
resource "aws_iam_policy" "policy" {
  name        = "aws_instance_profile_ec2"
  description = "politica de teste da ec2"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]

  })

  tags = merge(
    var.tags,
    {
      Name =  "aws assume policy"
    },
  )

}
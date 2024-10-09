provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_policy" "custome_rw_policy" {
  name = "CustomRWECRPolicy"
  description = "An example policy for allowing specific actions"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "CustomRWECRPolicy",
        Effect = "Allow",
        Action = [
            "ecr:GetDownloadUrlForLayer",
            "ecr:DescribeRegistry",
            "ecr:GetAuthorizationToken",
            "ecr:UploadLayerPart",
            "ecr:BatchDeleteImage",
            "ecr:ListImages",
            "ecr:PutImage",
            "ecr:BatchGetImage",
            "ecr:CompleteLayerUpload",
            "ecr:DescribeImages",
            "ecr:DescribeRepositories",
            "ecr:InitiateLayerUpload",
            "ecr:BatchCheckLayerAvailability"
        ],
        Resource = "*"
      }
    ]
})
}

resource "aws_iam_role" "custome_rw_role" {
  name = "CustomRWECRRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role = aws_iam_role.custome_rw_role.name
  policy_arn = aws_iam_policy.custome_rw_policy.arn
}

resource "aws_iam_role" "uat" {
  name = "eks-cluster-uat"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "uat-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.uat.name
}

resource "aws_eks_cluster" "uat" {
  name     = "uat"
  role_arn = aws_iam_role.uat.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.uat-private-us-east-2a.id,
      aws_subnet.uat-private-us-east-2b.id,
      aws_subnet.uat-public-us-east-2a.id,
      aws_subnet.uat-public-us-east-2b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.uat-AmazonEKSClusterPolicy]
}


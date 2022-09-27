resource "aws_iam_role" "uat-nodes" {
  name = "eks-node-group-uat-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "uat-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.uat-nodes.name
}

resource "aws_iam_role_policy_attachment" "uat-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.uat-nodes.name
}

resource "aws_iam_role_policy_attachment" "uat-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.uat-nodes.name
}

resource "aws_eks_node_group" "uat-private-nodes" {
  cluster_name    = aws_eks_cluster.uat.name
  node_group_name = "uat-private-nodes"
  node_role_arn   = aws_iam_role.uat-nodes.arn

  subnet_ids = [
    aws_subnet.uat-private-us-east-2a.id,
    aws_subnet.uat-private-us-east-2b.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.large"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }

  # launch_template {
  #   name    = aws_launch_template.eks-with-disks.name
  #   version = aws_launch_template.eks-with-disks.latest_version
  # }

  depends_on = [
    aws_iam_role_policy_attachment.uat-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.uat-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.uat-AmazonEC2ContainerRegistryReadOnly,
  ]
}

# resource "aws_launch_template" "eks-with-disks" {
#   name = "eks-with-disks"

#   key_name = "local-provisioner"

#   block_device_mappings {
#     device_name = "/dev/xvdb"

#     ebs {
#       volume_size = 50
#       volume_type = "gp2"
#     }
#   }
# }


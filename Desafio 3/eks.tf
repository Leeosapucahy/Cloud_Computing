#FUNÇÃO AWS QUE GUARDA PERMISSÕES CLUSTER
resource "aws_iam_role" "eks_cluster" {
  name               = "mp_leo-eks-cluster-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
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
 
#EKS POLICY
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name #ASSOSIAÇÃO A FUNÇÃO DE CIMA
}

#EKS SERVICE 
resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}
 
#CLUSTER
resource "aws_eks_cluster" "aws_eks" {
  name     = "mp_leo-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn #ROLE = ASSOSIAÇÃO
  vpc_config {
    subnet_ids = [aws_subnet.private_app_a.id, aws_subnet.private_app_c.id]
  }
  tags = {
    Name = "mp_leo-EKS-cluster"
  }
}

#NODES
resource "aws_iam_role" "eks_nodes" {
  name               = "mp_leo-eks-node-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
 
#WORKER NODE POLICY, PERMISSÃO PARA SUBIR MÁQUINA
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}
 
#CNI POLICY
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}
 
#CONTAINER REGISTRY
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

#NODE GROUP
resource "aws_eks_node_group" "node-group" {
  cluster_name    = aws_eks_cluster.aws_eks.name #cluster
  node_group_name = "mp_leo-node-group"
  node_role_arn   = aws_iam_role.eks_nodes.arn #node
  subnet_ids      = [aws_subnet.private_app_a.id, aws_subnet.private_app_c.id]
  instance_types = ["t2.medium"]
 
 #CONFIGURAÇÕES MÁQUINAS EC2
  scaling_config {
    desired_size = 3
    max_size     = 6
    min_size     = 3
  }
 
  tags = {
    Name = "mp_leo-node-group"
  }
 
  depends_on = [aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy, aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy, aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly, ]
}
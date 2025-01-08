output "eks_cluster_id" {
  description = "ID of the created EKS cluster"
  value       = aws_eks_cluster.this.id
}

output "eks_node_group_id" {
  description = "ID of the created EKS node group"
  value       = aws_eks_node_group.this.id
}

# output "eks_cluster_kubeconfig" {
#   description = "Kubeconfig for the EKS cluster"
#   value       = module.eks.kubeconfig
# }

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_arn" {
  value = aws_eks_cluster.this.arn
}

output "cluster_name" {
  value = aws_eks_cluster.this.name
}
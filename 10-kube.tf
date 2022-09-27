
resource "null_resource" "eks_context_switcher" {

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --profile snap --name ${var.eks_name} --region ${var.region}"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

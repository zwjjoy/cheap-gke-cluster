# ## deployment of the NGINX Ingress Controller

resource "null_resource" "kubectl_apply_ingress" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    when        = create
    interpreter = ["bash", "-c"]
    command     = "kubectl apply -f ./scripts/ingress.yaml"
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["bash", "-c"]
    command     = "kubectl delete -f ./scripts/ingress.yaml"
  }
}

resource "null_resource" "kubectl_apply_service" {
  depends_on  = [null_resource.kubectl_apply_ingress]
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    when        = create
    interpreter = ["bash", "-c"]
    command     = "kubectl apply -f ./scripts/service.yaml"
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["bash", "-c"]
    command     = "kubectl delete -f ./scripts/service.yaml"
  }
}

# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }

# resource "helm_release" "nginx_ingress" {
#   name       = "nginx-ingress"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx"
#   namespace  = "kube-system"
#   version    = "4.7.0"

#   values = [
#     <<EOF
# controller:
#   service:
#     type: LoadBalancer
#     annotations:
#       cloud.google.com/load-balancer-type: "External"
# EOF
#   ]
# }


# resource "null_resource" "deploy_nginx_ingress_controller" {
#     # null_resource.local_k8s_context
#     depends_on = [null_resource.local_k8s_context]

#     provisioner "local-exec" {
#         interpreter = ["bash", "-c"]
#         command = "./scripts/install-nginx.sh"
#     }
# }

# resource "null_resource" "wait_for_nginx_ingress" {
#   depends_on = [null_resource.deploy_nginx_ingress_controller]

#   provisioner "local-exec" {
#     interpreter = ["bash", "-c"]
#     command     = <<EOT
#       until kubectl get pods -n ingress-nginx | grep "Running"; do
#         echo "Waiting for NGINX Ingress Controller to be ready...";
#         sleep 30;
#       done
#     EOT
#   }
# }
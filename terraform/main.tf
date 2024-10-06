resource "google_compute_network" "default" {
  name                    = var.network_name
  auto_create_subnetworks = "false"
  project                 = var.project_id
  routing_mode            = "REGIONAL"
}

resource "null_resource" "set_default_network_tier" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = "gcloud compute project-info add-metadata --metadata google-compute-default-region-network-tier=STANDARD"
  }
}
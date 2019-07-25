variable "gke_machine_type" {
  default = "n1-standard-1"
}

variable gcp_project_id {
  default = "terraform-k8s-gke-traefik-demo"
}

variable gcp_project_name {
  default = "Demo Terraform k8s GKE traefik"
}

variable "gcp_billing_accpint_name" {
  default = "EVJA's billing"
}

variable region {
  default = "europe-west3"
}

variable zone {
  default = "europe-west3-c"
}

variable network_name {
  default = "tf-gke-k8s"
}
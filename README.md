# terraform-gcp-k8s-traefik

An example of how to deploy a cluster on GCP...using also Namespace

### Intro

This is a based on https://github.com/SantoDE/terraform-gcp-kubernetes-traefik

### Setup CLI

gcloud init
gcloud auth application-default login
export GOOGLE_PROJECT=$(gcloud config get-value project)

### Create Cluster

terraform init
terraform apply

### Setup Kubectl

gcloud container clusters get-credentials $(terraform output cluster_name) --zone $(terraform output cluster_zone)

### Spawn Namespace

kubectl apply -f services/namespace.yml

### Spawn Traefik as Ingress Controller

<!-- name space embedded -->
kubectl apply -f services/traefik

### Spawn Demo Services

kubectl apply -f services/whoami --namespace=terrifik
kubectl apply -f services/nginx --namespace=terrifik

### Destroy Cluster

terraform destroy

# Traefik on Google Cloud Kubernetes Engine with Terraform

The work done in this repository has been ispired and based on the following tutorials:

[Traefik on a Google Kubernetes Engine Cluster managed by Terraform](https://medium.com/google-cloud/traefik-on-a-google-kubernetes-engine-cluster-managed-by-terraform-ad871be8ee26)

https://github.com/SantoDE/terraform-gcp-kubernetes-traefik

[Using Traefik with TLS on Kubernetes](https://medium.com/@patrickeasters/using-traefik-with-tls-on-kubernetes-cb67fb43a948)

https://github.com/patrickeasters/traefik-k8s-tls-example

Thanks guys for your job.

## Requirements
* Google Cloud Account
* gcloud SDK installed
* GCP Project with Billing and Compute Engine Enabled
* Terraform
* kubectx and kubens (optional)

An example of how to deploy a cluster on GCP using:
* Terraform
* Kubernetes
* Namespace
* Traefik
    - SSL

## Steps

### Setup CLI
```
gcloud init
gcloud auth application-default login
export GOOGLE_PROJECT=$(gcloud config get-value project)
```

### Edit Files

As of RBAC Constraints on GKE, it's necessary to edit one file. 

[permissions.yml](services/traefik/01_permissions.yml)

You need to insert your gpc email account.

```
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: <your_gcp_account_email>
```

### Create Cluster
```
terraform init
terraform apply
```

### Setup Kubectl
```
gcloud container clusters get-credentials $(terraform output cluster_name) --zone $(terraform output cluster_zone)
```

### Spawn Namespace
```
kubectl apply -f services/namespace.yml
```

### Spawn Traefik as Ingress Controller
<!-- name space embedded -->
```
kubectl apply -f services/traefik
```

### Spawn Demo Services
```
kubectl apply -f services/whoami --namespace=terrifik
kubectl apply -f services/nginx --namespace=terrifik
```

### Destroy Cluster
```
terraform destroy
```

### SSL

Note: This is still a working progress so it might lack of some information.

Under the `Traefik` folder `services/traefik/ssl` you can find the relative files for `ssl`

You need just to substitute them in the order and run.

Before doing so you need to generate and save your certificates.

Generate a self-signed certificate:
```
openssl req \
        -newkey rsa:2048 -nodes -keyout tls.key \
        -x509 -days 365 -out tls.crt
```

Store it as a [secret](https://kubernetes.io/docs/concepts/configuration/secret/):
```
kubectl create secret generic traefik-cert \
        --from-file=tls.crt \
        --from-file=tls.key
```

Testing
```
curl -k https://myhost/
```
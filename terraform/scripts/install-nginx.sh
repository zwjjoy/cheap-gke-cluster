#!/usr/bin/env bash

# current script directory
# DIR="$( cd "$( dirname "$0" )" && pwd )"

# Add the NGINX ingress Helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Install the NGINX ingress controller using Helm
helm install nginx-ingress ingress-nginx/ingress-nginx \
    --create-namespace \
    --namespace ingress-nginx \
    -f values.yaml
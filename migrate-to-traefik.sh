#!/bin/bash

echo "🚀 Starting migration from nginx-ingress to Traefik..."

# Step 1: Delete existing certificates and secrets to force recreation
echo "1️⃣ Cleaning up existing certificates..."
kubectl delete certificate eggl-one-wildcard-tls -n neuland-app --ignore-not-found=true
kubectl delete certificate eggl-one-wildcard-tls -n verein-ext --ignore-not-found=true
kubectl delete secret eggl-one-wildcard-tls -n neuland-app --ignore-not-found=true
kubectl delete secret eggl-one-wildcard-tls -n verein-ext --ignore-not-found=true
kubectl delete secret letsencrypt-nginx -n cert-manager --ignore-not-found=true

# Step 2: Delete existing challenges and orders
echo "2️⃣ Cleaning up failed ACME challenges..."
kubectl delete challenges --all -A --ignore-not-found=true
kubectl delete orders --all -A --ignore-not-found=true

# Step 3: Apply new configuration
echo "3️⃣ Applying Traefik configuration..."
flux reconcile kustomization flux-system --with-source

echo "4️⃣ Waiting for Traefik to be ready..."
kubectl wait --for=condition=available deployment/traefik -n traefik --timeout=300s || echo "Traefik deployment not ready yet, continuing..."

# Step 5: Delete the old nginx-ingress
echo "5️⃣ Removing nginx-ingress controller..."
kubectl delete helmrelease ingress-nginx -n ingress-nginx --ignore-not-found=true
kubectl delete namespace ingress-nginx --ignore-not-found=true

# Step 6: Update ClusterIssuer
echo "6️⃣ Updating ClusterIssuer..."
kubectl delete clusterissuer letsencrypt --ignore-not-found=true

# Force another reconciliation to create the new ClusterIssuer
flux reconcile kustomization flux-system --with-source

echo "7️⃣ Waiting for certificates to be issued..."
sleep 30

echo "8️⃣ Checking certificate status..."
kubectl get certificates -A
kubectl get clusterissuer
kubectl get ingress -A

echo "✅ Migration complete! Check your websites in a few minutes."
echo "🔍 Monitor certificate status with: kubectl get certificates -A"
echo "🔍 Check Traefik status with: kubectl get pods -n traefik"

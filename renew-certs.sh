#!/bin/bash

echo "Forcing certificate renewal for eggl-one-wildcard..."

# Delete the existing certificate secret to force renewal
kubectl delete secret eggl-one-wildcard-tls -n cert-manager --ignore-not-found=true

# Delete the existing certificate resource (it will be recreated by flux)
kubectl delete certificate eggl-one-wildcard -n cert-manager --ignore-not-found=true

echo "Certificate and secret deleted. Waiting for Flux to recreate the certificate..."

# Wait a moment for the resources to be deleted
sleep 5

# Force Flux to reconcile immediately
flux reconcile kustomization flux-system --with-source

echo "Flux reconciliation triggered. Monitoring certificate status..."

# Wait for the certificate to be recreated and show status
kubectl wait --for=condition=Ready certificate/eggl-one-wildcard -n cert-manager --timeout=300s

echo "Certificate renewal complete! Checking final status:"
kubectl get certificate eggl-one-wildcard -n cert-manager
kubectl describe certificate eggl-one-wildcard -n cert-manager | grep -A5 "Status:"

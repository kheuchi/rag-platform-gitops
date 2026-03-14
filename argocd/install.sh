#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Creating argocd namespace..."
kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

echo "==> Adding ArgoCD Helm repo..."
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

echo "==> Installing ArgoCD..."
helm upgrade --install argocd argo/argo-cd \
  --namespace argocd \
  --values "$SCRIPT_DIR/values.yaml" \
  --version 7.7.5 \
  --wait --timeout 5m

echo "==> ArgoCD installed. Getting initial admin password..."
echo "Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)"
echo ""
echo "Access: kubectl port-forward svc/argocd-server -n argocd 8080:443"

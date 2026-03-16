#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> [1/4] Creating argocd namespace..."
kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

echo "==> [2/4] Installing ArgoCD via Helm..."
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm upgrade --install argocd argo/argo-cd \
  --namespace argocd \
  --values "$SCRIPT_DIR/values.yaml" \
  --version 7.7.5 \
  --wait --timeout 5m

echo "==> [3/4] Creating AppProject..."
kubectl apply -f "$SCRIPT_DIR/projects/rag-platform.yaml"

echo "==> [4/5] Deploying root ApplicationSet..."
kubectl apply -f "$SCRIPT_DIR/apps/root-appset.yaml"

echo "==> [5/5] Deploying platform Applications..."
for app in "$SCRIPT_DIR"/apps/*-app.yaml; do
  [ -f "$app" ] && kubectl apply -f "$app"
done

echo ""
echo "==> Bootstrap complete!"
echo "Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)"
echo "Access:   kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo ""
echo "ArgoCD will now auto-discover and sync any directory under tenants/*"
echo "Platform apps (argocd/apps/*-app.yaml) are managed by ArgoCD after bootstrap."

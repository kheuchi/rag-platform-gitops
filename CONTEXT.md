# RAG Platform â€” Project Context

> Ce fichier est la source de vÃ©ritÃ© du projet. Mis Ã  jour Ã  chaque fin de phase.
> Il est dupliquÃ© sur les 3 repos. Quand tu ouvres une nouvelle session Claude, dis-lui de lire ce fichier.

## DerniÃ¨re mise Ã  jour : 2026-04-09

## Architecture globale

```
rag-platform-infra   â†’ Terraform : AKS, VNet, Azure OpenAI, GCP Firestore, WIF
rag-platform-gitops  â†’ ArgoCD : NATS, KEDA, Crossplane, OTel Demo, deployments rag-dev
rag-platform-app     â†’ Code : FastAPI backend + NATS worker (Python)
```

## Cluster AKS â€” Ã‰tat actuel

| Composant | Namespace | Ã‰tat |
|-----------|-----------|------|
| ArgoCD | argocd | Running â€” https://13.92.13.5 |
| NATS JetStream | nats | Running â€” service `nats-helm`, stream `RAG` |
| KEDA | keda-system | Running |
| Crossplane | crossplane-system | Running |
| rag-backend | rag-dev | Running â€” 1/1 |
| rag-worker | rag-dev | 0 replicas (scale via KEDA) |
| OTel Demo | otel-demo | Running â€” Grafana + Prometheus + OTel Collector |
| Redis | Azure (Crossplane) | Basic C0 |

## Services cloud

| Service | Cloud | DÃ©tails |
|---------|-------|---------|
| AKS aks-rag-dev | Azure East US | D2s_v3 system + D4s_v3 spot x0-2 |
| Azure OpenAI oai-rag-dev | Azure East US | gpt-4o + text-embedding-3-small, S0 |
| GCP Firestore | GCP us-central1 | Native mode, collection `code-chunks`, 1536 dims |
| Vertex AI | GCP | gemini-1.5-pro (LLM fallback, non encore testÃ©) |

## Env vars dans le cluster (rag-dev)

```
NATS_URL=nats://nats-helm.nats.svc.cluster.local:4222
AZURE_OPENAI_ENDPOINT=https://eastus.api.cognitive.microsoft.com/  (secret rag-ai-secrets)
AZURE_OPENAI_API_KEY=<secret rag-ai-secrets>
AZURE_OPENAI_CHAT_DEPLOYMENT=gpt-4o
AZURE_OPENAI_EMBEDDING_DEPLOYMENT=text-embedding-3-small
GCP_PROJECT_ID=mon-rag-perso-2026
FIRESTORE_DATABASE=(default)
FIRESTORE_COLLECTION=code-chunks
GCP_LOCATION=us-central1
OPENSEARCH_URL=http://otel-demo-opensearch.otel-demo.svc.cluster.local:9200
PROMETHEUS_URL=http://otel-demo-prometheus-server.otel-demo.svc.cluster.local:9090
JAEGER_URL=http://otel-demo-jaeger-query.otel-demo.svc.cluster.local:16686
```

## Phases

| Phase | Repo | Ã‰tat |
|-------|------|------|
| 0 â€” Structure repos | tous | âœ… Done |
| 1 â€” Networking Azure + GCP + WIF | infra | âœ… Done |
| 2 â€” AKS provisionnÃ© | infra | âœ… Done |
| 3 â€” ArgoCD + NATS + KEDA + Crossplane | gitops | âœ… Done |
| 4.1-4.4 â€” FastAPI backend + worker + LangGraph RCA | app | âœ… Done |
| 4.5a â€” Azure OpenAI + Firestore + AKS spot (Terraform) | infra | âœ… Done 2026-03-29 |
| 4.5b â€” GitOps : env vars + OTel Demo + KEDA fix | gitops | âœ… Done 2026-03-29 |
| 4.5c â€” Swap Azure AI Search â†’ Firestore dans le code | app | âœ… Done 2026-03-29 |
| **4.5d â€” e2e smoke test** | **app** | **â³ En cours** |
| 4.6 â€” Multi-cloud validation (Vertex AI fallback) | app | â¬œ Pending |
| 5 â€” Langfuse + Kubecost | tous | â¬œ Pending |
| 6 â€” RAG + MCP hybride (navigation code live) | app | â¬œ Planned |

## Phase 4.5d â€” Blockers identifiÃ©s (2026-03-30)

Le code app (store.py, code_search.py) est OK et les images Docker build/push OK (CI verte).
Le pipeline worker fonctionne (clone â†’ parse â†’ chunk â†’ embed) mais 3 blockers empÃªchent le smoke test complet :

1. **KEDA ScaledObject en erreur** â€” le trigger NATS JetStream ne peut pas contacter `nats-helm:8222` (monitoring endpoint). KEDA force le worker Ã  0 replicas en boucle. Le ScaledObject est dans `tenants/rag-dev/` du repo gitops. ArgoCD `selfHeal: true` restaure le scaler mÃªme si on le supprime manuellement.
   - **Fix** : dans le repo gitops, soit activer le port 8222 dans la config NATS Helm, soit changer `minReplicaCount: 0 â†’ 1` dans le ScaledObject, soit corriger le trigger NATS.

2. **Redis non accessible par le worker** â€” le worker log `Redis not available for status tracking: [Errno 111] Connect call failed ('localhost', 6380)`. Les env vars `REDIS_HOST`/`REDIS_KEY` du secret `rag-backend-secrets` ne semblent pas injectÃ©es dans le worker deployment.
   - **Fix** : dans le repo gitops, vÃ©rifier l'envFrom du worker deployment.

3. **Azure OpenAI rate limiting (429)** â€” le tier S0 rate-limit les embeddings (264 chunks). Le worker retry en boucle (60s backoff). Pas bloquant mais ralentit le test.

## DÃ©cisions d'architecture

### Pourquoi RAG plutÃ´t que MCP seul

Le choix du RAG (et non MCP pur) repose sur :

- **Recherche sÃ©mantique cross-repo** : avec N repos, un agent MCP ne peut pas ouvrir chaque fichier â€” le RAG prÃ©-indexe et retrouve par intention ("gestion d'erreur checkout") en ~100ms.
- **Confluence / docs non structurÃ©es** : un index vectoriel est nÃ©cessaire pour 1000+ pages. MCP lit page par page, trop lent.
- **CoÃ»t token maÃ®trisÃ©** : le RAG retourne 5-10 chunks, pas 50 fichiers entiers.
- **Portfolio** : dÃ©montre un pipeline data complet (ingestion async, event-driven, autoscaling, multi-cloud).

**Phase 6 prÃ©vue : hybride RAG + MCP** â€” RAG pour la dÃ©couverte sÃ©mantique, MCP pour la navigation directe (lecture fichiers, arborescence, git blame, doc Confluence). L'agent RCA utilisera les deux.

## Comptes

- Azure : Free Trial, subscription `9cee7c54-1645-4fd0-b027-18f4d49cae57`
- GCP : projet `mon-rag-perso-2026`, billing `0178A4-931D60-35809B` (Open)
- GitHub : `kheuchi`

## Conventions

- Conventional commits (`feat:`, `fix:`, `chore:`) â†’ semantic-release auto sur main
- Feature branches + PRs, jamais directement sur main
- `wsl` prefix pour toutes les commandes CLI (az, gcloud, kubectl, terraform)
- Secrets K8s via `kubectl create secret` â€” jamais dans git
- Platform Helm apps (`argocd/apps/*.yaml`) : `kubectl apply` manuel, pas via ArgoCD gitops


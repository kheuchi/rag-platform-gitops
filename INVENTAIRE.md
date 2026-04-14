# Inventaire des Ã©lÃ©ments installÃ©s et gÃ©rÃ©s

Ce document rÃ©sume les composants importants dÃ©jÃ  installÃ©s, dÃ©ployÃ©s ou configurÃ©s autour de `rag-platform-gitops`.

## 1. Ce que gÃ¨re ce repo

Ce dÃ©pÃ´t sert de couche GitOps pour la plateforme RAG. Il pilote ArgoCD, les applications Helm de la plateforme, les manifests des tenants Kubernetes et une partie du provisioning cloud via Crossplane.

## 2. Composants plateforme installÃ©s dans AKS

| Composant | Namespace cible | Source | Version / image | RÃ´le |
|---|---|---|---|---|
| ArgoCD | `argocd` | manifests repo (`argocd/`) | valeurs Helm custom dans `argocd/values.yaml` | Orchestration GitOps |
| NATS + JetStream | `nats` | chart Helm NATS | `nats` `1.2.6` | Bus d'Ã©vÃ©nements et persistance JetStream |
| KEDA | `keda` | chart Helm KEDA | `keda` `2.16.1` | Autoscaling Ã©vÃ¨nementiel |
| Crossplane | `crossplane-system` | chart Helm Crossplane | `crossplane` `1.18.0` | Provisioning cloud depuis Kubernetes |
| OpenTelemetry Demo | `otel-demo` | chart Helm OTel Demo | `opentelemetry-demo` `0.32.8` | ObservabilitÃ©: Grafana, Prometheus, OpenSearch, Jaeger, OTel Collector |

## 3. Workloads applicatifs installÃ©s

| Workload | Namespace | Image | Ã‰tat attendu | DÃ©tails importants |
|---|---|---|---|---|
| `rag-backend` | `rag-dev` | `ghcr.io/kheuchi/rag-backend:latest` | `1` replica | API FastAPI exposÃ©e via service `rag-backend` |
| `rag-worker` | `rag-dev` | `ghcr.io/kheuchi/rag-worker:latest` | `0` replica au repos | Worker pilotÃ© par KEDA |
| `rag-worker-scaler` | `rag-dev` | KEDA `ScaledObject` | `0 -> 5` replicas | Scale sur le lag JetStream du stream `RAG` |

## 4. Ressources cloud dÃ©jÃ  branchÃ©es dans ce repo

| Ressource | Type | Gestion | DÃ©tails |
|---|---|---|---|
| Redis Azure `redis-rag-dev` | `RedisCache` | Crossplane | SKU `Basic C0`, rÃ©gion `East US`, TLS 1.2 |
| Provider Azure Cache | Provider Crossplane | Crossplane | `xpkg.upbound.io/upbound/provider-azure-cache:v1` |
| Provider GCP Redis | Provider Crossplane | Crossplane | `xpkg.upbound.io/upbound/provider-gcp-redis:v1` |
| ProviderConfig Azure | Config provider | Crossplane | `azure-default` |

## 5. IntÃ©grations applicatives dÃ©jÃ  configurÃ©es

Les variables d'environnement des workloads montrent que les intÃ©grations suivantes sont dÃ©jÃ  branchÃ©es:

| IntÃ©gration | Utilisation |
|---|---|
| NATS | transport des jobs d'ingestion |
| JetStream stream `RAG` | file durable consommÃ©e par le worker |
| Azure OpenAI | chat `gpt-4o` + embeddings `text-embedding-3-small` |
| GCP Firestore | stockage / recherche vectorielle dans `code-chunks` |
| Vertex AI | fallback LLM prÃ©vu via `GCP_LOCATION=us-central1` |
| OpenSearch | logs |
| Prometheus | mÃ©triques |
| Jaeger | traces |
| Redis Azure | cache / stockage backend selon les secrets injectÃ©s |

## 6. Structure GitOps dÃ©jÃ  en place

| Ã‰lÃ©ment | Fichier | RÃ´le |
|---|---|---|
| AppProject ArgoCD | `argocd/projects/rag-platform.yaml` | borne les sources et destinations autorisÃ©es |
| Root `ApplicationSet` | `argocd/apps/root-appset.yaml` | gÃ©nÃ¨re une application ArgoCD par sous-rÃ©pertoire de `tenants/` |
| Tenant `rag-dev` | `tenants/rag-dev/` | backend, worker, autoscaling |
| Tenant `crossplane` | `tenants/crossplane/` | providers + ressource Redis |

## 7. Outillage repo dÃ©jÃ  installÃ© localement

| Outil | Statut | DÃ©tails |
|---|---|---|
| `node_modules` | prÃ©sent localement | dÃ©pendances npm dÃ©jÃ  installÃ©es |
| `semantic-release` | configurÃ© | release automatique sur `main` |
| `@semantic-release/changelog` | configurÃ© | mise Ã  jour du changelog |
| `@semantic-release/git` | configurÃ© | commit des artefacts de release |
| GitHub Actions release | configurÃ© | workflow `.github/workflows/release.yml` |

## 8. RÃ©sumÃ© rapide

Aujourd'hui, la base plateforme est dÃ©jÃ  en place dans ce repo:

- GitOps ArgoCD opÃ©rationnel
- messaging NATS/JetStream prÃªt
- autoscaling KEDA branchÃ© sur le worker
- observabilitÃ© OTel Demo + Grafana/Prometheus/OpenSearch/Jaeger prÃ©sente
- provisioning Redis Azure via Crossplane prÃ©sent
- backend et worker `rag-dev` cÃ¢blÃ©s sur Azure OpenAI, Firestore, Redis et l'observabilitÃ©
- pipeline de release npm/github dÃ©jÃ  installÃ© cÃ´tÃ© repo

## 9. Limites de cet inventaire

Cet inventaire reflÃ¨te ce qui est visible dans `CONTEXT.md` et les manifests de ce dÃ©pÃ´t. Il ne valide pas en direct l'Ã©tat rÃ©el du cluster ni des services cloud au moment de lecture.




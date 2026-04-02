# Inventaire des éléments installés et gérés

Ce document résume les composants importants déjà installés, déployés ou configurés autour de `rag-platform-gitops`.

## 1. Ce que gère ce repo

Ce dépôt sert de couche GitOps pour la plateforme RAG. Il pilote ArgoCD, les applications Helm de la plateforme, les manifests des tenants Kubernetes et une partie du provisioning cloud via Crossplane.

## 2. Composants plateforme installés dans AKS

| Composant | Namespace cible | Source | Version / image | Rôle |
|---|---|---|---|---|
| ArgoCD | `argocd` | manifests repo (`argocd/`) | valeurs Helm custom dans `argocd/values.yaml` | Orchestration GitOps |
| NATS + JetStream | `nats` | chart Helm NATS | `nats` `1.2.6` | Bus d'événements et persistance JetStream |
| KEDA | `keda` | chart Helm KEDA | `keda` `2.16.1` | Autoscaling évènementiel |
| Crossplane | `crossplane-system` | chart Helm Crossplane | `crossplane` `1.18.0` | Provisioning cloud depuis Kubernetes |
| OpenTelemetry Demo | `otel-demo` | chart Helm OTel Demo | `opentelemetry-demo` `0.32.8` | Observabilité: Grafana, Prometheus, Loki, Tempo, OTel Collector |

## 3. Workloads applicatifs installés

| Workload | Namespace | Image | État attendu | Détails importants |
|---|---|---|---|---|
| `rag-backend` | `rag-dev` | `ghcr.io/kheuchi/rag-backend:latest` | `1` replica | API FastAPI exposée via service `rag-backend` |
| `rag-worker` | `rag-dev` | `ghcr.io/kheuchi/rag-worker:latest` | `0` replica au repos | Worker piloté par KEDA |
| `rag-worker-scaler` | `rag-dev` | KEDA `ScaledObject` | `0 -> 5` replicas | Scale sur le lag JetStream du stream `RAG` |

## 4. Ressources cloud déjà branchées dans ce repo

| Ressource | Type | Gestion | Détails |
|---|---|---|---|
| Redis Azure `redis-rag-dev` | `RedisCache` | Crossplane | SKU `Basic C0`, région `East US`, TLS 1.2 |
| Provider Azure Cache | Provider Crossplane | Crossplane | `xpkg.upbound.io/upbound/provider-azure-cache:v1` |
| Provider GCP Redis | Provider Crossplane | Crossplane | `xpkg.upbound.io/upbound/provider-gcp-redis:v1` |
| ProviderConfig Azure | Config provider | Crossplane | `azure-default` |

## 5. Intégrations applicatives déjà configurées

Les variables d'environnement des workloads montrent que les intégrations suivantes sont déjà branchées:

| Intégration | Utilisation |
|---|---|
| NATS | transport des jobs d'ingestion |
| JetStream stream `RAG` | file durable consommée par le worker |
| Azure OpenAI | chat `gpt-4o` + embeddings `text-embedding-3-small` |
| GCP Firestore | stockage / recherche vectorielle dans `code-chunks` |
| Vertex AI | fallback LLM prévu via `GCP_LOCATION=us-central1` |
| Loki | logs |
| Prometheus | métriques |
| Tempo | traces |
| Redis Azure | cache / stockage backend selon les secrets injectés |

## 6. Structure GitOps déjà en place

| Élément | Fichier | Rôle |
|---|---|---|
| AppProject ArgoCD | `argocd/projects/rag-platform.yaml` | borne les sources et destinations autorisées |
| Root `ApplicationSet` | `argocd/apps/root-appset.yaml` | génère une application ArgoCD par sous-répertoire de `tenants/` |
| Tenant `rag-dev` | `tenants/rag-dev/` | backend, worker, autoscaling |
| Tenant `crossplane` | `tenants/crossplane/` | providers + ressource Redis |

## 7. Outillage repo déjà installé localement

| Outil | Statut | Détails |
|---|---|---|
| `node_modules` | présent localement | dépendances npm déjà installées |
| `semantic-release` | configuré | release automatique sur `main` |
| `@semantic-release/changelog` | configuré | mise à jour du changelog |
| `@semantic-release/git` | configuré | commit des artefacts de release |
| GitHub Actions release | configuré | workflow `.github/workflows/release.yml` |

## 8. Résumé rapide

Aujourd'hui, la base plateforme est déjà en place dans ce repo:

- GitOps ArgoCD opérationnel
- messaging NATS/JetStream prêt
- autoscaling KEDA branché sur le worker
- observabilité OTel Demo + Grafana/Prometheus/Loki/Tempo présente
- provisioning Redis Azure via Crossplane présent
- backend et worker `rag-dev` câblés sur Azure OpenAI, Firestore, Redis et l'observabilité
- pipeline de release npm/github déjà installé côté repo

## 9. Limites de cet inventaire

Cet inventaire reflète ce qui est visible dans `CONTEXT.md` et les manifests de ce dépôt. Il ne valide pas en direct l'état réel du cluster ni des services cloud au moment de lecture.

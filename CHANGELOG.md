## [1.3.6](https://github.com/kheuchi/rag-platform-gitops/compare/v1.3.5...v1.3.6) (2026-04-13)

### Bug Fixes

* **rag-backend:** bump memory 512Mi -> 1Gi for RCA agent ([#9](https://github.com/kheuchi/rag-platform-gitops/issues/9)) ([c940211](https://github.com/kheuchi/rag-platform-gitops/commit/c9402116525c6a4a07227352d6642c28fa8ac178))

## [1.3.5](https://github.com/kheuchi/rag-platform-gitops/compare/v1.3.4...v1.3.5) (2026-04-10)

### Bug Fixes

* mount GCP credentials secret in backend and worker deployments ([ad5ae9f](https://github.com/kheuchi/rag-platform-gitops/commit/ad5ae9f22ae79515c503e210bc2cbc4ec36a3aec))

## [1.3.4](https://github.com/kheuchi/rag-platform-gitops/compare/v1.3.3...v1.3.4) (2026-04-10)

### Bug Fixes

* disable non-essential OTel Demo services to fit on D2s_v3 node ([36d49e8](https://github.com/kheuchi/rag-platform-gitops/commit/36d49e88823839d5bb9d4baf64c53394b60722bb))

## [1.3.3](https://github.com/kheuchi/rag-platform-gitops/compare/v1.3.2...v1.3.3) (2026-04-10)

### Bug Fixes

* disable Langfuse (replicas 0) to free resources for worker ([8690d83](https://github.com/kheuchi/rag-platform-gitops/commit/8690d836cb753c6c57447400247cf1b1ceeecbf2))

## [1.3.2](https://github.com/kheuchi/rag-platform-gitops/compare/v1.3.1...v1.3.2) (2026-04-10)

### Bug Fixes

* remove spot toleration and reduce worker resources for scheduling ([c864cd6](https://github.com/kheuchi/rag-platform-gitops/commit/c864cd6fe3ac5b4ab3a631315c4d7ab7eed1e6e8))

## [1.3.1](https://github.com/kheuchi/rag-platform-gitops/compare/v1.3.0...v1.3.1) (2026-04-10)

### Bug Fixes

* resolve KEDA/NATS blockers for worker autoscaling ([92dc70a](https://github.com/kheuchi/rag-platform-gitops/commit/92dc70a12af8f18800fbedbe8de3e0d8ebd00102))

### Documentation

* sync CONTEXT.md, rewrite README with full GitOps architecture ([615bda3](https://github.com/kheuchi/rag-platform-gitops/commit/615bda32577f8df2148d68eaf5c56d97da53ee61))

## [1.3.0](https://github.com/kheuchi/rag-platform-gitops/compare/v1.2.3...v1.3.0) (2026-04-08)

### Features

* fix KEDA/Redis blockers, add catalog, Langfuse, Kubecost (Phase 5) ([b0aefe2](https://github.com/kheuchi/rag-platform-gitops/commit/b0aefe24fe7d608540045324c458d5f1cb1b5cf0))

### Documentation

* add platform inventory ([0ba68d9](https://github.com/kheuchi/rag-platform-gitops/commit/0ba68d9ec356e5183857745d8f66209830624754))
* **context:** add CONTEXT.md — shared project status file for LLM context engineering ([38e95cc](https://github.com/kheuchi/rag-platform-gitops/commit/38e95ccbb988f8eff04100dcece0e306fa2a5567))

## [1.2.3](https://github.com/kheuchi/rag-platform-gitops/compare/v1.2.2...v1.2.3) (2026-03-29)

### Bug Fixes

* **otel-demo:** disable checkoutService (depends on disabled Kafka) ([62a0376](https://github.com/kheuchi/rag-platform-gitops/commit/62a03764ada65e1cdff2b2d6403f0034dda073ec))

## [1.2.2](https://github.com/kheuchi/rag-platform-gitops/compare/v1.2.1...v1.2.2) (2026-03-29)

### Bug Fixes

* **otel-demo:** remove invalid default.resources from Helm values schema ([21d86f9](https://github.com/kheuchi/rag-platform-gitops/commit/21d86f989a8d1b00f2c005be8af56265f906512b))

## [1.2.1](https://github.com/kheuchi/rag-platform-gitops/compare/v1.2.0...v1.2.1) (2026-03-29)

### Bug Fixes

* **argocd:** add OTel Demo Helm repo to rag-platform project sourceRepos ([a84046e](https://github.com/kheuchi/rag-platform-gitops/commit/a84046ed0ab23d5d04a292d2ae66dba46e37ec3a))

## [1.2.0](https://github.com/kheuchi/rag-platform-gitops/compare/v1.1.2...v1.2.0) (2026-03-29)

### Features

* **rag-dev:** phase 4.5b — Azure OpenAI, Firestore, KEDA fix, OTel Demo ([#8](https://github.com/kheuchi/rag-platform-gitops/issues/8)) ([687e1e9](https://github.com/kheuchi/rag-platform-gitops/commit/687e1e95757fce2657ff81a55688a303c7256480)), closes [#7](https://github.com/kheuchi/rag-platform-gitops/issues/7)

## [1.1.2](https://github.com/kheuchi/rag-platform-gitops/compare/v1.1.1...v1.1.2) (2026-03-16)

### Bug Fixes

* **rag-dev:** correct NATS service name to nats-helm ([e019d76](https://github.com/kheuchi/rag-platform-gitops/commit/e019d769d625bda3368ed6dc08efe8e57498f002))

## [1.1.1](https://github.com/kheuchi/rag-platform-gitops/compare/v1.1.0...v1.1.1) (2026-03-16)

### Bug Fixes

* **crossplane:** add required redisVersion field to Redis claim ([a2fef73](https://github.com/kheuchi/rag-platform-gitops/commit/a2fef73da3bac6524f2b225d72f7f0eeff3b8a82))

## [1.1.0](https://github.com/kheuchi/rag-platform-gitops/compare/v1.0.1...v1.1.0) (2026-03-16)

### Features

* **platform:** add Redis, NATS, KEDA and base RAG workloads ([a219622](https://github.com/kheuchi/rag-platform-gitops/commit/a21962269fbd7d6a367b7b5f25b71cd4e72a6a89))

## [1.0.1](https://github.com/kheuchi/rag-platform-gitops/compare/v1.0.0...v1.0.1) (2026-03-16)

### Bug Fixes

* **argocd:** add SkipDryRunOnMissingResource for CRD ordering ([5b45c4c](https://github.com/kheuchi/rag-platform-gitops/commit/5b45c4ca28f30b303f930cd14ce3a7fd37a16224))
* **crossplane:** use UserAssignedManagedIdentity for ProviderConfig ([47d0ec3](https://github.com/kheuchi/rag-platform-gitops/commit/47d0ec3dc145c72e70acea86fdd4b840ac7548a6))

## 1.0.0 (2026-03-16)

### Features

* **argocd:** add ArgoCD setup with app-of-apps pattern ([1e04362](https://github.com/kheuchi/rag-platform-gitops/commit/1e043627e225f3135eafc0b9e25e38e91ddc5052))
* **ci:** add semantic-release with auto changelog ([9a3d068](https://github.com/kheuchi/rag-platform-gitops/commit/9a3d068048a13d8dc56d12cd2584df1b887c4da6))
* **crossplane:** add Crossplane tenant with Azure/GCP providers ([c4ef779](https://github.com/kheuchi/rag-platform-gitops/commit/c4ef7795f079f99505de3fc6d05269dce90f0f9a))
* **settings:** add additional Bash commands for Kubernetes and Azure management ([ea42f12](https://github.com/kheuchi/rag-platform-gitops/commit/ea42f12e1275626324fb5a656553d31aa6f994c6))

### Bug Fixes

* **argocd:** correct GitHub username from cheikh-ak to kheuchi ([a4a249f](https://github.com/kheuchi/rag-platform-gitops/commit/a4a249f093c0e37236425b7bffb8d922b4a57f33))
* **argocd:** disable redis networkPolicy to fix helm upgrade ([4e398b7](https://github.com/kheuchi/rag-platform-gitops/commit/4e398b722c92bf180d2603872ce1312a60319066))
* **argocd:** move crossplane Helm app out of tenants to argocd/apps ([d3ceba0](https://github.com/kheuchi/rag-platform-gitops/commit/d3ceba0f614129882f93252db42e4cf9ba45cb14))
* **crossplane,argocd:** set real Azure IDs and re-enable HTTPS ([c7cd00e](https://github.com/kheuchi/rag-platform-gitops/commit/c7cd00ebb79fe1a2f3791d61956e69eaf7b972c7))

### Refactoring

* **argocd:** replace app-of-apps with ApplicationSet pattern ([b862d0e](https://github.com/kheuchi/rag-platform-gitops/commit/b862d0e96896f9eb6ba424c075709547131483a2))

# Changelog

All notable changes to this project will be automatically documented here by semantic-release.

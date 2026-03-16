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

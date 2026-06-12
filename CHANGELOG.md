# Changelog

## [2.2.0](https://github.com/portefaix/portefaix-kubernetes/compare/v2.1.1...v2.2.0) (2026-06-12)


### 🚀 Features

* **config:** improve opentelemetry collector configuration with tail sampling and connectors ([#7096](https://github.com/portefaix/portefaix-kubernetes/issues/7096)) ([efd79d2](https://github.com/portefaix/portefaix-kubernetes/commit/efd79d214ef951db132bc5ec18db23074208a717))
* **loki:** ACK naming resources ([#7083](https://github.com/portefaix/portefaix-kubernetes/issues/7083)) ([b0c22db](https://github.com/portefaix/portefaix-kubernetes/commit/b0c22db667fc77872c7702b44f9435f8880b5768))
* **loki:** add ACK support and refactor to distributed mode ([#7075](https://github.com/portefaix/portefaix-kubernetes/issues/7075)) ([3c8b43f](https://github.com/portefaix/portefaix-kubernetes/commit/3c8b43f3dd4e247100c55b0326313e5fbb785a0c))
* **loki:** use Crossplane Cloudflare R2 bucket ([#7084](https://github.com/portefaix/portefaix-kubernetes/issues/7084)) ([9d601df](https://github.com/portefaix/portefaix-kubernetes/commit/9d601dfa61894a2196080d16e2475a05bb6f4ee4))
* **tempo:** add ACK and Crossplane configuration ([#7086](https://github.com/portefaix/portefaix-kubernetes/issues/7086)) ([5d4017b](https://github.com/portefaix/portefaix-kubernetes/commit/5d4017be46f808d5eaa99fb1478a0e3dfc934603))


### 🐛 Bug Fixes

* **kagent:** OCI repository for CRDs ([#7073](https://github.com/portefaix/portefaix-kubernetes/issues/7073)) ([782db65](https://github.com/portefaix/portefaix-kubernetes/commit/782db65325d99e4b354d3b1ca7366faf5b70e809))


### 🚨 Maintenance

* **deps:** update corentinmusard/otel-cicd-action action to v4.0.1 ([#7081](https://github.com/portefaix/portefaix-kubernetes/issues/7081)) ([2fbb956](https://github.com/portefaix/portefaix-kubernetes/commit/2fbb9569ceb543b2775f93849d343bc56427b09e))
* **deps:** update helm release greptimedb-operator to 0.6.0 ([#7076](https://github.com/portefaix/portefaix-kubernetes/issues/7076)) ([7d7b652](https://github.com/portefaix/portefaix-kubernetes/commit/7d7b65229b19e870e4b8ca4d9137aaba89140149))
* **deps:** update helm release kubewarden-controller to 5.14.0 ([#7077](https://github.com/portefaix/portefaix-kubernetes/issues/7077)) ([2c82828](https://github.com/portefaix/portefaix-kubernetes/commit/2c8282859958b672e69c8f4889cf9812109c995a))
* **deps:** update loki docker tag to v17 ([#7082](https://github.com/portefaix/portefaix-kubernetes/issues/7082)) ([65264c1](https://github.com/portefaix/portefaix-kubernetes/commit/65264c154828d3cd8645bcb39482f86d95373128))
* **deps:** update pyroscope-mixin docker tag to v1.6.0 ([#7080](https://github.com/portefaix/portefaix-kubernetes/issues/7080)) ([6e37e80](https://github.com/portefaix/portefaix-kubernetes/commit/6e37e8045ec413761a49993171a9642cb1909e84))
* **deps:** update step-security/harden-runner action to v2.19.4 ([#7099](https://github.com/portefaix/portefaix-kubernetes/issues/7099)) ([81e4ac6](https://github.com/portefaix/portefaix-kubernetes/commit/81e4ac6c68a2f0fdb0277683b3c738defa978ce8))

## [2.1.1](https://github.com/portefaix/portefaix-kubernetes/compare/v2.1.0...v2.1.1) (2026-06-10)


### 🚨 Maintenance

* **deps:** update crossplane docker tag to v2.3.2 ([#7069](https://github.com/portefaix/portefaix-kubernetes/issues/7069)) ([3f2cb90](https://github.com/portefaix/portefaix-kubernetes/commit/3f2cb901af93de78d83e396e180adae68673266c))
* **deps:** update helm release greptimedb-cluster to 0.8.18 ([#7070](https://github.com/portefaix/portefaix-kubernetes/issues/7070)) ([72d144a](https://github.com/portefaix/portefaix-kubernetes/commit/72d144ae8aa4f818293d9868e2851179f39e025e))
* **deps:** update helm release keda to 2.20.1 ([#7063](https://github.com/portefaix/portefaix-kubernetes/issues/7063)) ([45fff1d](https://github.com/portefaix/portefaix-kubernetes/commit/45fff1d7a7c4ed23edb45d6404c09ebb635817bb))
* **deps:** update helm release meilisearch to 0.32.0 ([#7064](https://github.com/portefaix/portefaix-kubernetes/issues/7064)) ([9da8c22](https://github.com/portefaix/portefaix-kubernetes/commit/9da8c229657989d28bc2c648b77ce7be6daa39ed))
* **deps:** update helm release moco to 0.25.0 ([#7065](https://github.com/portefaix/portefaix-kubernetes/issues/7065)) ([56e1ba1](https://github.com/portefaix/portefaix-kubernetes/commit/56e1ba171e4e94a43e7e0b0e150673e152d590fd))
* **deps:** update helm release open-feature-operator to v0.9.2 ([#7066](https://github.com/portefaix/portefaix-kubernetes/issues/7066)) ([5a2409c](https://github.com/portefaix/portefaix-kubernetes/commit/5a2409c7f8a7a74d5547d6c0b4234a842c792d1a))
* **deps:** update helm release qdrant to 1.18.2 ([#7067](https://github.com/portefaix/portefaix-kubernetes/issues/7067)) ([4a7a4ae](https://github.com/portefaix/portefaix-kubernetes/commit/4a7a4ae82ec107a1637298c6612ba6040506d164))

## [2.1.0](https://github.com/portefaix/portefaix-kubernetes/compare/v2.0.0...v2.1.0) (2026-06-10)


### 🚀 Features

* **fluxcd:** remove component ([#7020](https://github.com/portefaix/portefaix-kubernetes/issues/7020)) ([1277fe9](https://github.com/portefaix/portefaix-kubernetes/commit/1277fe9ee7e10c99a53a52600466cce78a156b3b))
* **krm:** KRM components: Crossplane, ACK, ... ([#7059](https://github.com/portefaix/portefaix-kubernetes/issues/7059)) ([7906afa](https://github.com/portefaix/portefaix-kubernetes/commit/7906afa4ad277b8b6c0b11eb04049cfd7541b6c8))
* **workflows:** use sha for Github Actions ([#7019](https://github.com/portefaix/portefaix-kubernetes/issues/7019)) ([7392260](https://github.com/portefaix/portefaix-kubernetes/commit/73922604c12234c852272b0404f637226b3c638f))

### 🐛 Bug Fixes

* **workflows:** update default branch to main ([#7017](https://github.com/portefaix/portefaix-kubernetes/issues/7017)) ([cf4979f](https://github.com/portefaix/portefaix-kubernetes/commit/cf4979fb63bd68bebcd7461376ada8718664e8e5))

### 🚨 Maintenance

* **deps:** update ack-chart docker tag to v46.106.2 ([#7027](https://github.com/portefaix/portefaix-kubernetes/issues/7027)) ([4869423](https://github.com/portefaix/portefaix-kubernetes/commit/48694238ce82cd57cc97a677bce66a115e640e45))
* **deps:** update actions/add-to-project action to v2.0.0 ([#7008](https://github.com/portefaix/portefaix-kubernetes/issues/7008)) ([d029c12](https://github.com/portefaix/portefaix-kubernetes/commit/d029c12a3ddabd4f91fcd9fd2437fcee6a3ec89b))
* **deps:** update argo-workflows docker tag to v1 ([#7009](https://github.com/portefaix/portefaix-kubernetes/issues/7009)) ([038e218](https://github.com/portefaix/portefaix-kubernetes/commit/038e2186d2923035fb4dfe0e1792d968ee167d41))
* **deps:** update authentik docker tag to v2026 ([#7039](https://github.com/portefaix/portefaix-kubernetes/issues/7039)) ([bf118f0](https://github.com/portefaix/portefaix-kubernetes/commit/bf118f02f89ed9b73d719bb1e82ee8f9de5304ef))
* **deps:** update falco docker tag to v9 ([#7010](https://github.com/portefaix/portefaix-kubernetes/issues/7010)) ([c1324f3](https://github.com/portefaix/portefaix-kubernetes/commit/c1324f3cfe88723149ea82fdd61ef258918bb553))
* **deps:** update ghcr.io/tarampampam/error-pages docker tag to v4 ([#7011](https://github.com/portefaix/portefaix-kubernetes/issues/7011)) ([031573a](https://github.com/portefaix/portefaix-kubernetes/commit/031573a1d46cb538a360e9f722dde82994c6b01f))
* **deps:** update github artifact actions to v7.0.1 ([#7012](https://github.com/portefaix/portefaix-kubernetes/issues/7012)) ([463b5fd](https://github.com/portefaix/portefaix-kubernetes/commit/463b5fd2f2126b20e00415584103cd19b12fb01d))
* **deps:** update grafana monorepo ([#7040](https://github.com/portefaix/portefaix-kubernetes/issues/7040)) ([cd023e4](https://github.com/portefaix/portefaix-kubernetes/commit/cd023e43600a6380f1c38013c82160f87015b35d))
* **deps:** update helm release alloy to 1.9.0 ([#7041](https://github.com/portefaix/portefaix-kubernetes/issues/7041)) ([4c6e2d1](https://github.com/portefaix/portefaix-kubernetes/commit/4c6e2d1e7e7bfffdee3a02b06d48f3e1cc3355eb))
* **deps:** update helm release altinity-clickhouse-operator to 0.27.1 ([#7023](https://github.com/portefaix/portefaix-kubernetes/issues/7023)) ([7b54867](https://github.com/portefaix/portefaix-kubernetes/commit/7b548671ff3498957b1ae5500b52ff2cf8d8bf34))
* **deps:** update helm release cert-manager-crds to 1.20.0 ([#7029](https://github.com/portefaix/portefaix-kubernetes/issues/7029)) ([b0d6ebd](https://github.com/portefaix/portefaix-kubernetes/commit/b0d6ebde8c60428f0c84f48f85893eac848dd2de))
* **deps:** update helm release external-dns to 1.21.1 ([#7055](https://github.com/portefaix/portefaix-kubernetes/issues/7055)) ([dc55186](https://github.com/portefaix/portefaix-kubernetes/commit/dc55186462cf8c9e186290804c7f1d404421660b))
* **deps:** update helm release loki to 7.0.0 ([#7013](https://github.com/portefaix/portefaix-kubernetes/issues/7013)) ([d744f10](https://github.com/portefaix/portefaix-kubernetes/commit/d744f10c08698a0d0ee9c4b1c6ca8f0c27f7f400))
* **deps:** update helm release mariadb-operator to 26.6.0 ([#7042](https://github.com/portefaix/portefaix-kubernetes/issues/7042)) ([0997404](https://github.com/portefaix/portefaix-kubernetes/commit/09974044513705bbe1c5b9b77bb069087469c178))
* **deps:** update helm release mariadb-operator-crds to 26.6.0 ([#7043](https://github.com/portefaix/portefaix-kubernetes/issues/7043)) ([365bdd5](https://github.com/portefaix/portefaix-kubernetes/commit/365bdd5227d326f7a8a484947ba3857942d22cf4))
* **deps:** update helm release pyroscope to 2.0.3 ([#7044](https://github.com/portefaix/portefaix-kubernetes/issues/7044)) ([8ce7aa0](https://github.com/portefaix/portefaix-kubernetes/commit/8ce7aa01509f8a667ef0549976239165d86c224b))
* **deps:** update kagent docker tag to v0.9.6 ([#7047](https://github.com/portefaix/portefaix-kubernetes/issues/7047)) ([204f81b](https://github.com/portefaix/portefaix-kubernetes/commit/204f81be68befa6d2e8d2078a7a8838dbcea9f8b))
* **deps:** update kargo docker tag to v1.10.6 ([#7048](https://github.com/portefaix/portefaix-kubernetes/issues/7048)) ([0267afa](https://github.com/portefaix/portefaix-kubernetes/commit/0267afa11119f5484171c7f19a5f56c5f05f9063))
* **deps:** update karpenter docker tag to v1.12.1 ([#7049](https://github.com/portefaix/portefaix-kubernetes/issues/7049)) ([68f0885](https://github.com/portefaix/portefaix-kubernetes/commit/68f0885a0866f38c07964710ca0548281f4196e5))
* **deps:** update karpenter-crd docker tag to v1.12.1 ([#7050](https://github.com/portefaix/portefaix-kubernetes/issues/7050)) ([1e97746](https://github.com/portefaix/portefaix-kubernetes/commit/1e97746d5a8b5e502aea6d923ae473a70e0d9973))
* **deps:** update kgateway-crds docker tag to v2.3.2 ([#7051](https://github.com/portefaix/portefaix-kubernetes/issues/7051)) ([eebbc08](https://github.com/portefaix/portefaix-kubernetes/commit/eebbc0899fa98f9750b14cd7dfd39f96bddfa368))
* **deps:** update kube-prometheus-stack docker tag to v86 ([#7014](https://github.com/portefaix/portefaix-kubernetes/issues/7014)) ([92d5f8b](https://github.com/portefaix/portefaix-kubernetes/commit/92d5f8bf9576a20866461e46166ab94acdef2e63))
* **deps:** update kured docker tag to v6 ([#7045](https://github.com/portefaix/portefaix-kubernetes/issues/7045)) ([5e8a86f](https://github.com/portefaix/portefaix-kubernetes/commit/5e8a86f485c5cff353a97893e2bc1c8471c1b897))
* **deps:** update opentelemetry-collector docker tag to v0.158.1 ([#7052](https://github.com/portefaix/portefaix-kubernetes/issues/7052)) ([23eb9a7](https://github.com/portefaix/portefaix-kubernetes/commit/23eb9a701ec9a3a0c6fea2811d3354c944cb0857))
* **deps:** update opentelemetry-operator docker tag to v0.114.1 ([#7033](https://github.com/portefaix/portefaix-kubernetes/issues/7033)) ([6c1a64b](https://github.com/portefaix/portefaix-kubernetes/commit/6c1a64ba304acaa0d4e4ed572497a387dc101da3))
* **deps:** update pre-commit hook compilerla/conventional-pre-commit to v4.4.0 ([#7034](https://github.com/portefaix/portefaix-kubernetes/issues/7034)) ([3e1645f](https://github.com/portefaix/portefaix-kubernetes/commit/3e1645fbec01007b83bc46f9e4a06cfd4dc0309c))
* **deps:** update pre-commit hook gitleaks/gitleaks to v8.30.1 ([#7035](https://github.com/portefaix/portefaix-kubernetes/issues/7035)) ([eb3094f](https://github.com/portefaix/portefaix-kubernetes/commit/eb3094f6828d520fc5f499a2e7102d034a73fc36))
* **deps:** update pre-commit hook python-jsonschema/check-jsonschema to 0.37.2 ([#7036](https://github.com/portefaix/portefaix-kubernetes/issues/7036)) ([bd915da](https://github.com/portefaix/portefaix-kubernetes/commit/bd915dabd5e42dc861f42503243019a44d2e2037))
* **deps:** update pre-commit hook spinergie/pre-commit-dprint to v0.54.0 ([#7037](https://github.com/portefaix/portefaix-kubernetes/issues/7037)) ([488e3b8](https://github.com/portefaix/portefaix-kubernetes/commit/488e3b8627cc773c6c00a9452a293c582f543bf9))
* **deps:** update prometheus-operator-crds docker tag to v29 ([#7015](https://github.com/portefaix/portefaix-kubernetes/issues/7015)) ([48cf4b1](https://github.com/portefaix/portefaix-kubernetes/commit/48cf4b10693fea7b824937b7db47501316d9804f))
* **deps:** update softprops/action-gh-release action to v3.0.0 ([#7016](https://github.com/portefaix/portefaix-kubernetes/issues/7016)) ([bb11bed](https://github.com/portefaix/portefaix-kubernetes/commit/bb11bed46916b1d0d99a6f410d5c0023f9649281))
* **deps:** update tempo-distributed docker tag to v1.61.3 ([#7038](https://github.com/portefaix/portefaix-kubernetes/issues/7038)) ([b2f027f](https://github.com/portefaix/portefaix-kubernetes/commit/b2f027f01b44b342084f9228b67c82853c1c530c))
* **deps:** update traefik docker tag to v40 ([#7046](https://github.com/portefaix/portefaix-kubernetes/issues/7046)) ([9a20c2e](https://github.com/portefaix/portefaix-kubernetes/commit/9a20c2eceaba53063d67b444f72f672695b2e37c))

## [2.0.0](https://github.com/portefaix/portefaix-kubernetes/compare/v1.4.0...v2.0.0) (2026-06-09)


### ⚠ BREAKING CHANGES

* add project structure files and drop release-drafter ([#6995](https://github.com/portefaix/portefaix-kubernetes/issues/6995))

### Features

* add project structure files and drop release-drafter ([#6995](https://github.com/portefaix/portefaix-kubernetes/issues/6995)) ([4f23cf2](https://github.com/portefaix/portefaix-kubernetes/commit/4f23cf27caada306a44bdb5cec798f23ff1a4bd0))
* **opentelemetry:** OpenTelemetry Semantic Conventions enrichment ([#6985](https://github.com/portefaix/portefaix-kubernetes/issues/6985)) ([75deae3](https://github.com/portefaix/portefaix-kubernetes/commit/75deae3c39e7853970e49b4bf0134932e67340ce))


### Bug Fixes

* **project:** bootstrap automation and security workflows ([#7002](https://github.com/portefaix/portefaix-kubernetes/issues/7002)) ([685db2f](https://github.com/portefaix/portefaix-kubernetes/commit/685db2f439dc03909c17be14cc77f61b8422642d))

## [1.4.0](https://github.com/portefaix/portefaix-kubernetes/compare/v1.3.0...v1.4.0) (2026-03-13)

### 🚧 Changes

- Migration to OCI Helm charts
  ([#6745](https://github.com/portefaix/portefaix-kubernetes/issues/6745))

### 🚀 Features

- **opentelemetry:** correct otel collector pipeline and batch
  ([#6974](https://github.com/portefaix/portefaix-kubernetes/issues/6974))
- **opentelemetry:** improve transform and filter processor configuration
  ([#6959](https://github.com/portefaix/portefaix-kubernetes/issues/6959))
- Switch OTel Collectors communication to OTLP/Arrow
  ([#6934](https://github.com/portefaix/portefaix-kubernetes/issues/6934))
- **local-path-provisioner:** use OCI chart
  ([#6924](https://github.com/portefaix/portefaix-kubernetes/issues/6924))
- Priority classes for pod scheduling
  ([#6846](https://github.com/portefaix/portefaix-kubernetes/issues/6846))
- KRM application
  ([#6845](https://github.com/portefaix/portefaix-kubernetes/issues/6845))
- AI on Kubernetes
  ([#6834](https://github.com/portefaix/portefaix-kubernetes/issues/6834))
- LSP for Kubernetes manifests
  ([#6833](https://github.com/portefaix/portefaix-kubernetes/issues/6833))
- OpenTelemetry Collector for AI
  ([#6768](https://github.com/portefaix/portefaix-kubernetes/issues/6768))
- Migration of Cloudflare Tunnel to another namespace
  ([#6720](https://github.com/portefaix/portefaix-kubernetes/issues/6720))
- Clean obsolete tools
  ([#6657](https://github.com/portefaix/portefaix-kubernetes/issues/6657))
- Argo-CD AWS ACK health check
  ([#6644](https://github.com/portefaix/portefaix-kubernetes/issues/6644))
- GreptimeDB component
  ([#6627](https://github.com/portefaix/portefaix-kubernetes/issues/6627))
- routing and compliance
  ([#6626](https://github.com/portefaix/portefaix-kubernetes/issues/6626))
- CardinalHQ Chip deployment
  ([#6605](https://github.com/portefaix/portefaix-kubernetes/issues/6605))
- [Helm] Migrate some charts to OCI Artifacts
  ([#6596](https://github.com/portefaix/portefaix-kubernetes/issues/6596))

### 🐛 Bug Fixes

- **opentelemetry:** fix filelog receiver, gateway otelarrow pipeline,…
  ([#6977](https://github.com/portefaix/portefaix-kubernetes/issues/6977))
- **opentelemetry:** correct otel collector pipeline and batch
  ([#6974](https://github.com/portefaix/portefaix-kubernetes/issues/6974))
- **opentelemetry:** correct memory\_limiter configuration
  ([#6971](https://github.com/portefaix/portefaix-kubernetes/issues/6971))
- **opentelemetry:** improve transform and filter processor configuration
  ([#6959](https://github.com/portefaix/portefaix-kubernetes/issues/6959))
- Some cleanup
  ([#6901](https://github.com/portefaix/portefaix-kubernetes/issues/6901))

### 🚨 Maintenance

- **deps:** update github/codeql-action action to v3.32.6
  ([#6981](https://github.com/portefaix/portefaix-kubernetes/issues/6981))
- **deps:** update argo-cd docker tag to v9.4.7
  ([#6972](https://github.com/portefaix/portefaix-kubernetes/issues/6972))
- **deps:** update peter-evans/create-pull-request action to v8
  ([#6963](https://github.com/portefaix/portefaix-kubernetes/issues/6963))
- **deps:** update actions/upload-artifact action to v7.0.0
  ([#6966](https://github.com/portefaix/portefaix-kubernetes/issues/6966))
- **deps:** update actions/labeler action to v6.0.1
  ([#6965](https://github.com/portefaix/portefaix-kubernetes/issues/6965))
- **deps:** update github/codeql-action action to v3.32.5
  ([#6969](https://github.com/portefaix/portefaix-kubernetes/issues/6969))
- **deps:** update github/codeql-action action to v3.32.4
  ([#6957](https://github.com/portefaix/portefaix-kubernetes/issues/6957))
- **deps:** update github/codeql-action action to v3.32.2
  ([#6946](https://github.com/portefaix/portefaix-kubernetes/issues/6946))
- **deps:** update actions/checkout action
  ([#6926](https://github.com/portefaix/portefaix-kubernetes/issues/6926))
- **deps:** update github/codeql-action action to v3.31.6
  ([#6921](https://github.com/portefaix/portefaix-kubernetes/issues/6921))
- **deps:** update helm release sbom-operator to 0.40.0
  ([#6911](https://github.com/portefaix/portefaix-kubernetes/issues/6911))
- **deps:** update github/codeql-action action to v3.31.5
  ([#6887](https://github.com/portefaix/portefaix-kubernetes/issues/6887))
- **deps:** update actions/checkout action to v4.3.1
  ([#6886](https://github.com/portefaix/portefaix-kubernetes/issues/6886))
- **deps:** update kgateway-crds docker tag to v2
  ([#6875](https://github.com/portefaix/portefaix-kubernetes/issues/6875))
- **deps:** update kube-prometheus-stack docker tag to v79
  ([#6876](https://github.com/portefaix/portefaix-kubernetes/issues/6876))
- **deps:** update opencost docker tag to v2
  ([#6877](https://github.com/portefaix/portefaix-kubernetes/issues/6877))
- **deps:** update ansible to 13.0.0
  ([#6878](https://github.com/portefaix/portefaix-kubernetes/issues/6878))
- **deps:** update github/codeql-action action to v3.31.2
  ([#6865](https://github.com/portefaix/portefaix-kubernetes/issues/6865))
- **deps:** update grafana-operator-crds docker tag to v1.1.0
  ([#6787](https://github.com/portefaix/portefaix-kubernetes/issues/6787))
- **deps:** update gateway-api-crds docker tag to v1.3.0
  ([#6786](https://github.com/portefaix/portefaix-kubernetes/issues/6786))
- **deps:** update argo-cd docker tag to v9
  ([#6803](https://github.com/portefaix/portefaix-kubernetes/issues/6803))
- **deps:** update ghcr.io/tarampampam/error-pages docker tag to v3
  ([#6804](https://github.com/portefaix/portefaix-kubernetes/issues/6804))
- **deps:** update jpmcb/prow-github-actions action to v2.0.0
  ([#6805](https://github.com/portefaix/portefaix-kubernetes/issues/6805))
- **deps:** update kube-prometheus-stack docker tag to v78
  ([#6806](https://github.com/portefaix/portefaix-kubernetes/issues/6806))
- **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v6.0.0
  ([#6807](https://github.com/portefaix/portefaix-kubernetes/issues/6807))
- **deps:** update prometheus-blackbox-exporter docker tag to v11
  ([#6808](https://github.com/portefaix/portefaix-kubernetes/issues/6808))
- **deps:** update prometheus-snmp-exporter docker tag to v9 - autoclosed
  ([#6810](https://github.com/portefaix/portefaix-kubernetes/issues/6810))
- **deps:** update redis docker tag to v8
  ([#6811](https://github.com/portefaix/portefaix-kubernetes/issues/6811))
- **deps:** update traefik docker tag to v37
  ([#6812](https://github.com/portefaix/portefaix-kubernetes/issues/6812))
- **deps:** update github/codeql-action action to v3.30.8
  ([#6791](https://github.com/portefaix/portefaix-kubernetes/issues/6791))
- **deps:** update ossf/scorecard-action action to v2.4.3
  ([#6778](https://github.com/portefaix/portefaix-kubernetes/issues/6778))
- **deps:** update github/codeql-action action to v3.30.6
  ([#6776](https://github.com/portefaix/portefaix-kubernetes/issues/6776))
- **deps:** update helm release signoz to 0.92.0
  ([#6754](https://github.com/portefaix/portefaix-kubernetes/issues/6754))
- **deps:** update helm release pyroscope to 1.15.0
  ([#6744](https://github.com/portefaix/portefaix-kubernetes/issues/6744))
- **deps:** update helm release qdrant to 1.15.4
  ([#6746](https://github.com/portefaix/portefaix-kubernetes/issues/6746))
- **deps:** update helm release metrics-server to 3.13.0
  ([#6735](https://github.com/portefaix/portefaix-kubernetes/issues/6735))
- **deps:** update helm release opentelemetry-operator to 0.95.0
  ([#6741](https://github.com/portefaix/portefaix-kubernetes/issues/6741))
- **deps:** update helm release port-k8s-exporter to 0.3.18
  ([#6742](https://github.com/portefaix/portefaix-kubernetes/issues/6742))
- **deps:** update helm release open-feature-operator to v0.8.7
  ([#6739](https://github.com/portefaix/portefaix-kubernetes/issues/6739))
- **deps:** update helm release opentelemetry-collector to 0.133.0
  ([#6740](https://github.com/portefaix/portefaix-kubernetes/issues/6740))
- **deps:** update github/codeql-action action to v3.30.3
  ([#6731](https://github.com/portefaix/portefaix-kubernetes/issues/6731))
- **deps:** update ack-chart docker tag to v46.46.0
  ([#6713](https://github.com/portefaix/portefaix-kubernetes/issues/6713))
- **deps:** update helm release dex to 0.24.0
  ([#6712](https://github.com/portefaix/portefaix-kubernetes/issues/6712))
- **deps:** update helm release loki to 6.40.0
  ([#6716](https://github.com/portefaix/portefaix-kubernetes/issues/6716))
- **deps:** update github/codeql-action action to v3.30.0
  ([#6718](https://github.com/portefaix/portefaix-kubernetes/issues/6718))
- **deps:** update helm release greptimedb-cluster to 0.6.19
  ([#6685](https://github.com/portefaix/portefaix-kubernetes/issues/6685))
- **deps:** update gateway-helm docker tag to v1.5.0
  ([#6677](https://github.com/portefaix/portefaix-kubernetes/issues/6677))
- **deps:** update github/codeql-action action to v3.29.11
  ([#6684](https://github.com/portefaix/portefaix-kubernetes/issues/6684))
- **deps:** update helm release dex to 0.23.1
  ([#6658](https://github.com/portefaix/portefaix-kubernetes/issues/6658))
- **deps:** update pre-commit hook python-jsonschema/check-jsonschema to 0.33.3
  ([#6661](https://github.com/portefaix/portefaix-kubernetes/issues/6661))
- **deps:** update ack-chart docker tag to v46.40.0
  ([#6662](https://github.com/portefaix/portefaix-kubernetes/issues/6662))
- **deps:** update actions/checkout action to v4.3.0
  ([#6668](https://github.com/portefaix/portefaix-kubernetes/issues/6668))
- **deps:** update github/codeql-action action to v3.29.10
  ([#6666](https://github.com/portefaix/portefaix-kubernetes/issues/6666))
- **deps:** update github/codeql-action action to v3.29.8
  ([#6655](https://github.com/portefaix/portefaix-kubernetes/issues/6655))
- **deps:** update actions/add-to-project action to v1.0.2
  ([#6653](https://github.com/portefaix/portefaix-kubernetes/issues/6653))
- **deps:** update fluxcd/flux2 action to v2.6.4
  ([#6635](https://github.com/portefaix/portefaix-kubernetes/issues/6635))
- **deps:** update github/codeql-action action to v3.29.1
  ([#6642](https://github.com/portefaix/portefaix-kubernetes/issues/6642))
- **deps:** update ossf/scorecard-action action to v2.4.2
  ([#6631](https://github.com/portefaix/portefaix-kubernetes/issues/6631))
- **deps:** update ack-chart docker tag to v46.30.3
  ([#6610](https://github.com/portefaix/portefaix-kubernetes/issues/6610))
- **deps:** update helm release datadog to 3.119.0
  ([#6611](https://github.com/portefaix/portefaix-kubernetes/issues/6611))
- **deps:** update helm release keda to 2.17.2
  ([#6613](https://github.com/portefaix/portefaix-kubernetes/issues/6613))
- **deps:** update helm release kubewarden-controller to 5.3.0
  ([#6617](https://github.com/portefaix/portefaix-kubernetes/issues/6617))
- **deps:** update helm release kube-aws to 3.19.0
  ([#6614](https://github.com/portefaix/portefaix-kubernetes/issues/6614))
- **deps:** update helm release kube-azure to 3.19.0
  ([#6615](https://github.com/portefaix/portefaix-kubernetes/issues/6615))
- **deps:** update helm release kube-gcp to 3.19.0
  ([#6616](https://github.com/portefaix/portefaix-kubernetes/issues/6616))
- **deps:** update github/codeql-action action to v3.28.18
  ([#6612](https://github.com/portefaix/portefaix-kubernetes/issues/6612))
- **deps:** update helm release altinity-clickhouse-operator to 0.25.0
  ([#6603](https://github.com/portefaix/portefaix-kubernetes/issues/6603))
- **deps:** update helm release homepage to 2.1.0
  ([#6583](https://github.com/portefaix/portefaix-kubernetes/issues/6583))
- **deps:** update helm release opentelemetry-operator to 0.89.0
  ([#6580](https://github.com/portefaix/portefaix-kubernetes/issues/6580))
- **deps:** update github/codeql-action action to v3.28.17
  ([#6571](https://github.com/portefaix/portefaix-kubernetes/issues/6571))
- **deps:** update argo-cd docker tag to v7.9.1
  ([#6564](https://github.com/portefaix/portefaix-kubernetes/issues/6564))

## [1.3.0](https://github.com/portefaix/portefaix-kubernetes/compare/v1.2.0...v1.3.0) (2025-05-06)

### 🚧 Changes

### 🚀 Features

- AWS Controllers for Kubernetes
  ([#6555](https://github.com/portefaix/portefaix-kubernetes/issues/6555))
- Add the Kube Resource Orchestrator (kro)
  ([#6254](https://github.com/portefaix/portefaix-kubernetes/issues/6254))
- Add alerting for OpenTelemetry collector
  ([#6553](https://github.com/portefaix/portefaix-kubernetes/issues/6553))
- Github Actions configuration with OpenTelemetry export
  ([#6451](https://github.com/portefaix/portefaix-kubernetes/issues/6451))

### 📚 Documentation

- Update release labels to v1.3.0
  ([#6558](https://github.com/portefaix/portefaix-kubernetes/issues/6558))

### 🚨 Maintenance

- **deps:** update helm release k8sgpt-operator to 0.2.17
  ([#6546](https://github.com/portefaix/portefaix-kubernetes/issues/6546))
- **deps:** update helm release opentelemetry-collector to 0.122.5
  ([#6547](https://github.com/portefaix/portefaix-kubernetes/issues/6547))
- **deps:** update helm release opentelemetry-operator to 0.88.4
  ([#6548](https://github.com/portefaix/portefaix-kubernetes/issues/6548))
- **deps:** update github/codeql-action action to v3.28.15
  ([#6551](https://github.com/portefaix/portefaix-kubernetes/issues/6551))
- **deps:** update step-security/harden-runner action to v2.11.1
  ([#6539](https://github.com/portefaix/portefaix-kubernetes/issues/6539))
- **deps:** update helm release loki to 6.29.0
  ([#6522](https://github.com/portefaix/portefaix-kubernetes/issues/6522))
- **deps:** update helm release nats to 1.3.1
  ([#6525](https://github.com/portefaix/portefaix-kubernetes/issues/6525))
- **deps:** update helm release ollama to 1.12.0
  ([#6526](https://github.com/portefaix/portefaix-kubernetes/issues/6526))
- **deps:** update helm release opentelemetry-collector to 0.120.0
  ([#6527](https://github.com/portefaix/portefaix-kubernetes/issues/6527))
- **deps:** update helm release opentelemetry-operator to 0.84.1
  ([#6528](https://github.com/portefaix/portefaix-kubernetes/issues/6528))
- **deps:** update helm release keep to 0.1.77
  ([#6509](https://github.com/portefaix/portefaix-kubernetes/issues/6509))
- **deps:** update grafana monorepo
  ([#6516](https://github.com/portefaix/portefaix-kubernetes/issues/6516))
- **deps:** update github/codeql-action action to v3.28.13
  ([#6517](https://github.com/portefaix/portefaix-kubernetes/issues/6517))
- **deps:** update alloy-mixin docker tag to v0.3.2
  ([#6497](https://github.com/portefaix/portefaix-kubernetes/issues/6497))
- **deps:** update cilium-mixin docker tag to v0.4.1
  ([#6498](https://github.com/portefaix/portefaix-kubernetes/issues/6498))
- **deps:** update portefaix-cel docker tag to v2.1.1
  ([#6501](https://github.com/portefaix/portefaix-kubernetes/issues/6501))
- **deps:** update pyrra-service-levels docker tag to v1.1.1
  ([#6502](https://github.com/portefaix/portefaix-kubernetes/issues/6502))
- **deps:** update helm release external-dns to 1.16.0
  ([#6504](https://github.com/portefaix/portefaix-kubernetes/issues/6504))
- **deps:** update helm release dex to 0.23.0
  ([#6505](https://github.com/portefaix/portefaix-kubernetes/issues/6505))
- **deps:** update helm release k8sgpt-operator to 0.2.10
  ([#6495](https://github.com/portefaix/portefaix-kubernetes/issues/6495))
- **deps:** update github/codeql-action action to v3.28.12
  ([#6494](https://github.com/portefaix/portefaix-kubernetes/issues/6494))
- **deps:** update actions/upload-artifact action to v4.6.2
  ([#6493](https://github.com/portefaix/portefaix-kubernetes/issues/6493))
- **deps:** update helm release keptn to 0.11.0
  ([#6490](https://github.com/portefaix/portefaix-kubernetes/issues/6490))
- **deps:** update karpenter docker tag to v1.3.3
  ([#6478](https://github.com/portefaix/portefaix-kubernetes/issues/6478))
- **deps:** update karpenter-crd docker tag to v1.3.3
  ([#6479](https://github.com/portefaix/portefaix-kubernetes/issues/6479))
- **deps:** update argo-rollouts docker tag to v2.39.1
  ([#6477](https://github.com/portefaix/portefaix-kubernetes/issues/6477))
- **deps:** update helm release homepage to 2.0.2
  ([#6475](https://github.com/portefaix/portefaix-kubernetes/issues/6475))
- **deps:** update argo-workflows docker tag to v0.45.11
  ([#6463](https://github.com/portefaix/portefaix-kubernetes/issues/6463))
- **deps:** update helm release alloy to 0.12.5
  ([#6464](https://github.com/portefaix/portefaix-kubernetes/issues/6464))
- **deps:** update helm release opentelemetry-operator to 0.83.0
  ([#6465](https://github.com/portefaix/portefaix-kubernetes/issues/6465))
- **deps:** update grafana-operator docker tag to v5.17.0
  ([#6469](https://github.com/portefaix/portefaix-kubernetes/issues/6469))
- **deps:** update github/codeql-action action to v3.28.11
  ([#6460](https://github.com/portefaix/portefaix-kubernetes/issues/6460))
- **deps:** update karpenter-crd docker tag to v1.3.1
  ([#6443](https://github.com/portefaix/portefaix-kubernetes/issues/6443))
- **deps:** update helm release keep to 0.1.68
  ([#6440](https://github.com/portefaix/portefaix-kubernetes/issues/6440))
- **deps:** update karpenter docker tag to v1.3.1
  ([#6441](https://github.com/portefaix/portefaix-kubernetes/issues/6441))
- **deps:** update gateway-helm docker tag to v1.3.1
  ([#6432](https://github.com/portefaix/portefaix-kubernetes/issues/6432))
- **deps:** update helm release moco to 0.16.0
  ([#6435](https://github.com/portefaix/portefaix-kubernetes/issues/6435))
- **deps:** update helm release nats to 1.2.11
  ([#6436](https://github.com/portefaix/portefaix-kubernetes/issues/6436))
- **deps:** update helm release opentelemetry-collector to 0.117.3
  ([#6439](https://github.com/portefaix/portefaix-kubernetes/issues/6439))
- **deps:** update argo-cd docker tag to v7.8.8
  ([#6428](https://github.com/portefaix/portefaix-kubernetes/issues/6428))
- **deps:** update helm release opentelemetry-operator to 0.82.0
  ([#6420](https://github.com/portefaix/portefaix-kubernetes/issues/6420))
- **deps:** update prometheus-snmp-exporter docker tag to v8
  ([#6423](https://github.com/portefaix/portefaix-kubernetes/issues/6423))
- **deps:** update karpenter docker tag to v1.3.0
  ([#6425](https://github.com/portefaix/portefaix-kubernetes/issues/6425))
- **deps:** update karpenter-crd docker tag to v1.3.0
  ([#6426](https://github.com/portefaix/portefaix-kubernetes/issues/6426))
- **deps:** update helm release keep to 0.1.67 - autoclosed
  ([#6414](https://github.com/portefaix/portefaix-kubernetes/issues/6414))
- **deps:** update dragonfly-operator docker tag to v1.1.10 - autoclosed
  ([#6416](https://github.com/portefaix/portefaix-kubernetes/issues/6416))
- **deps:** update argo-workflows docker tag to v0.45.9
  ([#6417](https://github.com/portefaix/portefaix-kubernetes/issues/6417))
- **deps:** update karpenter-crd docker tag to v1.2.2
  ([#6412](https://github.com/portefaix/portefaix-kubernetes/issues/6412))
- **deps:** update karpenter docker tag to v1.2.2 - autoclosed
  ([#6411](https://github.com/portefaix/portefaix-kubernetes/issues/6411))
- **deps:** update helm release datadog to 3.100.0
  ([#6408](https://github.com/portefaix/portefaix-kubernetes/issues/6408))

## [1.2.0](https://github.com/portefaix/portefaix-kubernetes/compare/v1.1.0...v1.2.0) (2025-02-28)

### 🚧 Changes

- Update license headers
  ([#6293](https://github.com/portefaix/portefaix-kubernetes/issues/6293))

### 🚀 Features

- OpenTelemetry refactoring
  ([#6381](https://github.com/portefaix/portefaix-kubernetes/issues/6381))
- Refactoring Observability stack
  ([#6333](https://github.com/portefaix/portefaix-kubernetes/issues/6333))
- Operator and instances
  ([#5708](https://github.com/portefaix/portefaix-kubernetes/issues/5708))
- Qdrant, a Vector database
  ([#6121](https://github.com/portefaix/portefaix-kubernetes/issues/6121))
- Ollama and k8sgpt
  ([#6080](https://github.com/portefaix/portefaix-kubernetes/issues/6080))
- refactoring configuration
  ([#6146](https://github.com/portefaix/portefaix-kubernetes/issues/6146))
- Service Levels Objective using Pyrra
  ([#6120](https://github.com/portefaix/portefaix-kubernetes/issues/6120))

### 🚨 Maintenance

- **deps:** update helm release altinity-clickhouse-operator to 0.24.4
  ([#6300](https://github.com/portefaix/portefaix-kubernetes/issues/6300))
- **deps:** update helm release opentelemetry-operator to 0.81.0
  ([#6399](https://github.com/portefaix/portefaix-kubernetes/issues/6399))
- **deps:** update kube-prometheus-stack docker tag to v69.6.0
  ([#6401](https://github.com/portefaix/portefaix-kubernetes/issues/6401))
- **deps:** update prometheus-operator-crds docker tag to v18 - autoclosed
  ([#6400](https://github.com/portefaix/portefaix-kubernetes/issues/6400))
- **deps:** update prometheus-snmp-exporter docker tag to v7
  ([#6402](https://github.com/portefaix/portefaix-kubernetes/issues/6402))
- **deps:** update pre-commit to 4.1.0
  ([#6403](https://github.com/portefaix/portefaix-kubernetes/issues/6403))
- **deps:** update kube-prometheus-stack docker tag to v69
  ([#6396](https://github.com/portefaix/portefaix-kubernetes/issues/6396))
- **deps:** update helm release kubewarden-controller to 5.0.0
  ([#6393](https://github.com/portefaix/portefaix-kubernetes/issues/6393))
- **deps:** update helm release kubewarden-defaults to 3.0.0
  ([#6394](https://github.com/portefaix/portefaix-kubernetes/issues/6394))
- **deps:** update helm release vertical-pod-autoscaler to 10.0.0
  ([#6395](https://github.com/portefaix/portefaix-kubernetes/issues/6395))
- **deps:** update tempo-distributed docker tag to v1.32.2
  ([#6392](https://github.com/portefaix/portefaix-kubernetes/issues/6392))
- **deps:** update helm release signoz to 0.72.0
  ([#6389](https://github.com/portefaix/portefaix-kubernetes/issues/6389))
- **deps:** update helm release ollama to 1.7.0
  ([#6377](https://github.com/portefaix/portefaix-kubernetes/issues/6377))
- **deps:** update helm release alloy to 0.12.0
  ([#6369](https://github.com/portefaix/portefaix-kubernetes/issues/6369))
- **deps:** update step-security/harden-runner action to v2.11.0
  ([#6374](https://github.com/portefaix/portefaix-kubernetes/issues/6374))
- **deps:** update helm release keep to 0.1.65
  ([#6366](https://github.com/portefaix/portefaix-kubernetes/issues/6366))
- **deps:** update helm release kubernetes-chaos to 3.16.0
  ([#6344](https://github.com/portefaix/portefaix-kubernetes/issues/6344))
- **deps:** update helm release litmus to 3.16.0
  ([#6346](https://github.com/portefaix/portefaix-kubernetes/issues/6346))
- **deps:** update helm release litmus-core to 3.16.0
  ([#6347](https://github.com/portefaix/portefaix-kubernetes/issues/6347))
- **deps:** update helm release opentelemetry-operator to 0.80.2
  ([#6355](https://github.com/portefaix/portefaix-kubernetes/issues/6355))
- **deps:** update helm release meilisearch to 0.12.0
  ([#6349](https://github.com/portefaix/portefaix-kubernetes/issues/6349))
- **deps:** update helm release ollama to 1.6.0
  ([#6353](https://github.com/portefaix/portefaix-kubernetes/issues/6353))
- **deps:** update helm release opentelemetry-collector to 0.117.0
  ([#6354](https://github.com/portefaix/portefaix-kubernetes/issues/6354))
- **deps:** update actions/upload-artifact action to v4.6.1
  ([#6352](https://github.com/portefaix/portefaix-kubernetes/issues/6352))
- **deps:** update ossf/scorecard-action action to v2.4.1
  ([#6351](https://github.com/portefaix/portefaix-kubernetes/issues/6351))
- **deps:** update github/codeql-action action to v3.28.10
  ([#6350](https://github.com/portefaix/portefaix-kubernetes/issues/6350))
- **deps:** update kargo docker tag to v1.2.3
  ([#6334](https://github.com/portefaix/portefaix-kubernetes/issues/6334))
- **deps:** update helm release dex to 0.22.0
  ([#6339](https://github.com/portefaix/portefaix-kubernetes/issues/6339))
- **deps:** update helm release datadog to 3.95.0
  ([#6338](https://github.com/portefaix/portefaix-kubernetes/issues/6338))
- **deps:** update helm release signoz to 0.71.0
  ([#6316](https://github.com/portefaix/portefaix-kubernetes/issues/6316))
- **deps:** update helm release keep to 0.1.64
  ([#6301](https://github.com/portefaix/portefaix-kubernetes/issues/6301))
- **deps:** update github/codeql-action action to v3.28.9
  ([#6306](https://github.com/portefaix/portefaix-kubernetes/issues/6306))
- **deps:** update argo-cd docker tag to v7.8.0
  ([#6275](https://github.com/portefaix/portefaix-kubernetes/issues/6275))
- **deps:** update karpenter docker tag to v1.2.1
  ([#6272](https://github.com/portefaix/portefaix-kubernetes/issues/6272))
- **deps:** update karpenter-crd docker tag to v1.2.1
  ([#6273](https://github.com/portefaix/portefaix-kubernetes/issues/6273))
- **deps:** update github/codeql-action action to v3.28.8
  ([#6252](https://github.com/portefaix/portefaix-kubernetes/issues/6252))
- **deps:** update docker.io/grafana/grafana docker tag to v11.5.0
  ([#6237](https://github.com/portefaix/portefaix-kubernetes/issues/6237))
- **deps:** update helm release quickwit to 0.7.11
  ([#6236](https://github.com/portefaix/portefaix-kubernetes/issues/6236))
- **deps:** update helm release k8sgpt-operator to 0.2.6
  ([#6234](https://github.com/portefaix/portefaix-kubernetes/issues/6234))
- **deps:** update argo-cd docker tag to v7.7.21
  ([#6233](https://github.com/portefaix/portefaix-kubernetes/issues/6233))
- **deps:** update gateway-helm docker tag to v1.2.6
  ([#6232](https://github.com/portefaix/portefaix-kubernetes/issues/6232))
- **deps:** update helm release alloy to 0.11.0
  ([#6239](https://github.com/portefaix/portefaix-kubernetes/issues/6239))
- **deps:** update helm release dex to 0.20.0
  ([#6226](https://github.com/portefaix/portefaix-kubernetes/issues/6226))
- **deps:** update helm release quickwit to 0.7.10
  ([#6222](https://github.com/portefaix/portefaix-kubernetes/issues/6222))
- **deps:** update github/codeql-action action to v3.28.5
  ([#6229](https://github.com/portefaix/portefaix-kubernetes/issues/6229))
- **deps:** update helm release loki to 6.25.0
  ([#6214](https://github.com/portefaix/portefaix-kubernetes/issues/6214))
- **deps:** update helm release mimir-distributed to 5.6.0
  ([#6215](https://github.com/portefaix/portefaix-kubernetes/issues/6215))
- **deps:** update helm release pyroscope to 1.12.0
  ([#6217](https://github.com/portefaix/portefaix-kubernetes/issues/6217))
- **deps:** update helm release ollama to 1.4.0
  ([#6216](https://github.com/portefaix/portefaix-kubernetes/issues/6216))
- **deps:** update step-security/harden-runner action to v2.10.4
  ([#6218](https://github.com/portefaix/portefaix-kubernetes/issues/6218))
- **deps:** update grafana-operator docker tag to v5.16.0
  ([#6196](https://github.com/portefaix/portefaix-kubernetes/issues/6196))
- **deps:** update helm release keep to 0.1.59
  ([#6193](https://github.com/portefaix/portefaix-kubernetes/issues/6193))
- **deps:** update helm release signoz to 0.66.0
  ([#6194](https://github.com/portefaix/portefaix-kubernetes/issues/6194))
- **deps:** update helm release ollama to 1.2.0
  ([#6188](https://github.com/portefaix/portefaix-kubernetes/issues/6188))
- **deps:** update github/codeql-action action to v3.28.1
  ([#6191](https://github.com/portefaix/portefaix-kubernetes/issues/6191))
- **deps:** update actions/upload-artifact action to v4.6.0
  ([#6192](https://github.com/portefaix/portefaix-kubernetes/issues/6192))
- **deps:** update helm release quickwit to 0.7.9
  ([#6182](https://github.com/portefaix/portefaix-kubernetes/issues/6182))
- **deps:** update argo-events docker tag to v2.4.13
  ([#6180](https://github.com/portefaix/portefaix-kubernetes/issues/6180))
- **deps:** update gateway-helm docker tag to v1.2.5
  ([#6181](https://github.com/portefaix/portefaix-kubernetes/issues/6181))
- **deps:** update helm release qdrant to 1.12.6
  ([#6168](https://github.com/portefaix/portefaix-kubernetes/issues/6168))
- **deps:** update helm release signoz to 0.65.2
  ([#6172](https://github.com/portefaix/portefaix-kubernetes/issues/6172))
- **deps:** update helm release k8s-infra to 0.12.0
  ([#6175](https://github.com/portefaix/portefaix-kubernetes/issues/6175))
- **deps:** update helm release opentelemetry-collector to 0.111.1
  ([#6176](https://github.com/portefaix/portefaix-kubernetes/issues/6176))
- **deps:** update argo-cd docker tag to v7.7.15
  ([#6178](https://github.com/portefaix/portefaix-kubernetes/issues/6178))
- **deps:** update step-security/harden-runner action to v2.10.3
  ([#6177](https://github.com/portefaix/portefaix-kubernetes/issues/6177))
- **deps:** update helm release pyroscope to 1.11.0
  ([#6160](https://github.com/portefaix/portefaix-kubernetes/issues/6160))
- **deps:** update helm release signoz to 0.65.0 - autoclosed
  ([#6157](https://github.com/portefaix/portefaix-kubernetes/issues/6157))
- **deps:** update helm release keep to 0.1.58
  ([#6156](https://github.com/portefaix/portefaix-kubernetes/issues/6156))
- **deps:** update helm release qdrant to 1.12.5
  ([#6153](https://github.com/portefaix/portefaix-kubernetes/issues/6153))
- **deps:** update helm release ollama to 1.1.2
  ([#6152](https://github.com/portefaix/portefaix-kubernetes/issues/6152))
- **deps:** update helm release keep to 0.1.55
  ([#6148](https://github.com/portefaix/portefaix-kubernetes/issues/6148))
- **deps:** update helm release keep to 0.1.54
  ([#6145](https://github.com/portefaix/portefaix-kubernetes/issues/6145))

## [1.1.0](https://github.com/portefaix/portefaix-kubernetes/compare/v1.0.0...v1.1.0) (2024-12-26)

### 🚧 Changes

### 🚀 Features

- Migrate to Postgres
  ([#6065](https://github.com/portefaix/portefaix-kubernetes/issues/6065))
- Robusta and HolmesGPT
  ([#6143](https://github.com/portefaix/portefaix-kubernetes/issues/6143))
- Use validating-admission-policy (VAP) as policy controller
  ([#5973](https://github.com/portefaix/portefaix-kubernetes/issues/5973))
- new component for alerting
  ([#5714](https://github.com/portefaix/portefaix-kubernetes/issues/5714))
- Use Moco as Mysql Operator
  ([#5932](https://github.com/portefaix/portefaix-kubernetes/issues/5932))
- MariaDB Operator setup
  ([#5921](https://github.com/portefaix/portefaix-kubernetes/issues/5921))
- Use Prometheus CRD to add the cluster label to metrics
  ([#5885](https://github.com/portefaix/portefaix-kubernetes/issues/5885))
- DORA metrics for Github with OpenTelemetry Collector
  ([#5718](https://github.com/portefaix/portefaix-kubernetes/issues/5718))
- Local path provisioner for Talos
  ([#5823](https://github.com/portefaix/portefaix-kubernetes/issues/5823))
- Tailscale component
  ([#5800](https://github.com/portefaix/portefaix-kubernetes/issues/5800))
- move applications to specific namespace
  ([#5799](https://github.com/portefaix/portefaix-kubernetes/issues/5799))
- Migrate applications for secrets management to a specific namespace
  ([#5798](https://github.com/portefaix/portefaix-kubernetes/issues/5798))
- Talos migration for Homelab
  ([#5719](https://github.com/portefaix/portefaix-kubernetes/issues/5719))

### 🐛 Bug Fixes

- Revert "Use Prometheus CRD to add the cluster label to metrics"
  ([#5898](https://github.com/portefaix/portefaix-kubernetes/issues/5898))

### 🚨 Maintenance

- **deps:** update kube-prometheus-stack docker tag to v67.5.0
  ([#6144](https://github.com/portefaix/portefaix-kubernetes/issues/6144))
- **deps:** update helm release keep to 0.1.53
  ([#6132](https://github.com/portefaix/portefaix-kubernetes/issues/6132))
- **deps:** update pyrra-service-levels docker tag to v1.1.0
  ([#6141](https://github.com/portefaix/portefaix-kubernetes/issues/6141))
- **deps:** update helm release meilisearch to 0.11.0
  ([#6131](https://github.com/portefaix/portefaix-kubernetes/issues/6131))
- **deps:** update pre-commit hook compilerla/conventional-pre-commit to v4.0.0
  ([#6128](https://github.com/portefaix/portefaix-kubernetes/issues/6128))
- **deps:** update github/codeql-action action to v3.28.0
  ([#6130](https://github.com/portefaix/portefaix-kubernetes/issues/6130))
- **deps:** update actions/upload-artifact action to v4.5.0
  ([#6118](https://github.com/portefaix/portefaix-kubernetes/issues/6118))
- **deps:** update bitnami/redis-exporter docker tag to v1.67.0-debian-12-r0
  ([#6096](https://github.com/portefaix/portefaix-kubernetes/issues/6096))
- **deps:** update oliver006/redis\_exporter docker tag to v1.67.0 - autoclosed
  ([#6095](https://github.com/portefaix/portefaix-kubernetes/issues/6095))
- **deps:** update helm release keep to 0.1.48
  ([#6094](https://github.com/portefaix/portefaix-kubernetes/issues/6094))
- **deps:** update prometheus-operator-crds docker tag to v17
  ([#6098](https://github.com/portefaix/portefaix-kubernetes/issues/6098))
- **deps:** update kube-prometheus-stack docker tag to v67
  ([#6097](https://github.com/portefaix/portefaix-kubernetes/issues/6097))
- **deps:** update traefik docker tag to v33.2.1
  ([#6089](https://github.com/portefaix/portefaix-kubernetes/issues/6089))
- **deps:** update helm release tetragon to 1.3.0 - autoclosed
  ([#6088](https://github.com/portefaix/portefaix-kubernetes/issues/6088))
- **deps:** update kube-prometheus-stack docker tag to v66.6.0
  ([#6091](https://github.com/portefaix/portefaix-kubernetes/issues/6091))
- **deps:** update github/codeql-action action to v3.27.9
  ([#6092](https://github.com/portefaix/portefaix-kubernetes/issues/6092))
- **deps:** update helm release signoz to 0.60.0
  ([#6081](https://github.com/portefaix/portefaix-kubernetes/issues/6081))
- **deps:** update tempo-distributed docker tag to v1.26.0
  ([#6082](https://github.com/portefaix/portefaix-kubernetes/issues/6082))
- **deps:** update gateway-helm docker tag to v1.2.4
  ([#6086](https://github.com/portefaix/portefaix-kubernetes/issues/6086))
- **deps:** update helm release keep to 0.1.47
  ([#6074](https://github.com/portefaix/portefaix-kubernetes/issues/6074))
- **deps:** update github/codeql-action action to v3.27.7
  ([#6073](https://github.com/portefaix/portefaix-kubernetes/issues/6073))
- **deps:** update argo-cd docker tag to v7.7.8
  ([#6055](https://github.com/portefaix/portefaix-kubernetes/issues/6055))
- **deps:** update helm release pyroscope to 1.10.0
  ([#6047](https://github.com/portefaix/portefaix-kubernetes/issues/6047))
- **deps:** update docker.io/grafana/grafana docker tag to v11.4.0
  ([#6051](https://github.com/portefaix/portefaix-kubernetes/issues/6051))
- **deps:** update helm release loki to 6.23.0
  ([#6053](https://github.com/portefaix/portefaix-kubernetes/issues/6053))
- **deps:** update kargo docker tag to v1.1.1
  ([#6054](https://github.com/portefaix/portefaix-kubernetes/issues/6054))
- **deps:** update github/codeql-action action to v3.27.6
  ([#6041](https://github.com/portefaix/portefaix-kubernetes/issues/6041))
- **deps:** update helm release keep to 0.1.45
  ([#6019](https://github.com/portefaix/portefaix-kubernetes/issues/6019))
- **deps:** update karpenter-crd docker tag to v1.1.0
  ([#6024](https://github.com/portefaix/portefaix-kubernetes/issues/6024))
- **deps:** update karpenter docker tag to v1.1.0
  ([#6023](https://github.com/portefaix/portefaix-kubernetes/issues/6023))
- **deps:** update helm release beyla to 1.5.0
  ([#6006](https://github.com/portefaix/portefaix-kubernetes/issues/6006))
- **deps:** update helm release keep to 0.1.42
  ([#5999](https://github.com/portefaix/portefaix-kubernetes/issues/5999))
- **deps:** update ansible to 11.0.0
  ([#5998](https://github.com/portefaix/portefaix-kubernetes/issues/5998))
- **deps:** update ruff to 0.8.0
  ([#5996](https://github.com/portefaix/portefaix-kubernetes/issues/5996))
- **deps:** update pyroscope-mixin docker tag to v1.5.0
  ([#5995](https://github.com/portefaix/portefaix-kubernetes/issues/5995))
- **deps:** update tempo-mixin docker tag to v1.8.0
  ([#5997](https://github.com/portefaix/portefaix-kubernetes/issues/5997))
- **deps:** update coredns-mixin docker tag to v1.5.0
  ([#5987](https://github.com/portefaix/portefaix-kubernetes/issues/5987))
- **deps:** update grafana-mixin docker tag to v1.5.0
  ([#5988](https://github.com/portefaix/portefaix-kubernetes/issues/5988))
- **deps:** update step-security/harden-runner action to v2.10.2
  ([#5986](https://github.com/portefaix/portefaix-kubernetes/issues/5986))
- **deps:** update cilium-mixin docker tag to v0.4.0
  ([#5985](https://github.com/portefaix/portefaix-kubernetes/issues/5985))
- **deps:** update alloy-mixin docker tag to v0.3.0
  ([#5984](https://github.com/portefaix/portefaix-kubernetes/issues/5984))
- **deps:** update kube-prometheus-stack docker tag to v66
  ([#5940](https://github.com/portefaix/portefaix-kubernetes/issues/5940))
- **deps:** update prometheus-operator-crds docker tag to v16
  ([#5942](https://github.com/portefaix/portefaix-kubernetes/issues/5942))
- **deps:** update github/codeql-action action to v3.27.5
  ([#5972](https://github.com/portefaix/portefaix-kubernetes/issues/5972))
- **deps:** update gateway-api-crds docker tag to v1.2.0
  ([#5963](https://github.com/portefaix/portefaix-kubernetes/issues/5963))
- **deps:** update helm release keep to 0.1.40
  ([#5956](https://github.com/portefaix/portefaix-kubernetes/issues/5956))
- **deps:** update github/codeql-action action to v3.27.4
  ([#5955](https://github.com/portefaix/portefaix-kubernetes/issues/5955))
- **deps:** update helm release pyrra to 0.14.0
  ([#5948](https://github.com/portefaix/portefaix-kubernetes/issues/5948))
- **deps:** update helm release datadog to 3.80.0
  ([#5941](https://github.com/portefaix/portefaix-kubernetes/issues/5941))
- **deps:** update github/codeql-action action to v3.27.3
  ([#5943](https://github.com/portefaix/portefaix-kubernetes/issues/5943))
- **deps:** update helm release quickwit to 0.7.7
  ([#5827](https://github.com/portefaix/portefaix-kubernetes/issues/5827))
- **deps:** update helm release meilisearch to 0.10.2
  ([#5848](https://github.com/portefaix/portefaix-kubernetes/issues/5848))
- **deps:** update actions/checkout action to v4.2.2
  ([#5845](https://github.com/portefaix/portefaix-kubernetes/issues/5845))
- **deps:** update github/codeql-action action to v3.27.0
  ([#5839](https://github.com/portefaix/portefaix-kubernetes/issues/5839))
- **deps:** update helm release alloy to 0.9.2
  ([#5835](https://github.com/portefaix/portefaix-kubernetes/issues/5835))
- **deps:** update github/codeql-action action to v3.26.12
  ([#5817](https://github.com/portefaix/portefaix-kubernetes/issues/5817))
- **deps:** update actions/checkout action to v4.2.1
  ([#5816](https://github.com/portefaix/portefaix-kubernetes/issues/5816))
- **deps:** update github/codeql-action action to v3.26.11
  ([#5790](https://github.com/portefaix/portefaix-kubernetes/issues/5790))
- **deps:** update github/codeql-action action to v3.26.10
  ([#5772](https://github.com/portefaix/portefaix-kubernetes/issues/5772))
- **deps:** update actions/checkout action to v4.2.0
  ([#5758](https://github.com/portefaix/portefaix-kubernetes/issues/5758))
- **deps:** update github/codeql-action action to v3.26.9
  ([#5756](https://github.com/portefaix/portefaix-kubernetes/issues/5756))
- **deps:** update helm release k8sgpt-operator to 0.2.0
  ([#5744](https://github.com/portefaix/portefaix-kubernetes/issues/5744))
- **deps:** update github/codeql-action action to v3.26.8
  ([#5735](https://github.com/portefaix/portefaix-kubernetes/issues/5735))

## [1.0.0](https://github.com/portefaix/portefaix-kubernetes/compare/v0.57.0...v1.0.0) (2024-09-14)

### 🚧 Changes

### 🚀 Features

- Migrate to Beyla official Helm chart
  ([#5255](https://github.com/portefaix/portefaix-kubernetes/issues/5255))
- new component
  ([#5700](https://github.com/portefaix/portefaix-kubernetes/issues/5700))

### 🚨 Maintenance

- **deps:** update github/codeql-action action to v3.26.7
  ([#5716](https://github.com/portefaix/portefaix-kubernetes/issues/5716))
- **deps:** update helm release beyla to 1.4.0
  ([#5710](https://github.com/portefaix/portefaix-kubernetes/issues/5710))
- **deps:** update step-security/harden-runner action to v2.10.1
  ([#5705](https://github.com/portefaix/portefaix-kubernetes/issues/5705))
- **deps:** update helm release descheduler to 0.31.0
  ([#5696](https://github.com/portefaix/portefaix-kubernetes/issues/5696))
- **deps:** update karpenter-crd docker tag to v1.0.2
  ([#5695](https://github.com/portefaix/portefaix-kubernetes/issues/5695))
- **deps:** update karpenter docker tag to v1.0.2
  ([#5694](https://github.com/portefaix/portefaix-kubernetes/issues/5694))
- **deps:** update cloudflare-tunnel docker tag to v0.4.0
  ([#5684](https://github.com/portefaix/portefaix-kubernetes/issues/5684))
- **deps:** update ruff to 0.6.4
  ([#5681](https://github.com/portefaix/portefaix-kubernetes/issues/5681))
- **deps:** update helm release tetragon to 1.2.0
  ([#5679](https://github.com/portefaix/portefaix-kubernetes/issues/5679))

## [0.57.0](https://github.com/portefaix/portefaix-kubernetes/compare/v0.56.0...v0.57.0) (2024-09-05)

### 🚧 Changes

- **deps:** update ansible to 10.2.0
  ([#5594](https://github.com/portefaix/portefaix-kubernetes/issues/5594))

### 🚀 Features

- Setup Vertical Pod Autoscaler
  ([#5678](https://github.com/portefaix/portefaix-kubernetes/issues/5678))
- Zero Trust: Paralus
  ([#4870](https://github.com/portefaix/portefaix-kubernetes/issues/4870))
- new application
  ([#5657](https://github.com/portefaix/portefaix-kubernetes/issues/5657))
- bump to v1
  ([#5630](https://github.com/portefaix/portefaix-kubernetes/issues/5630))
- Add Port Ocean
  ([#5571](https://github.com/portefaix/portefaix-kubernetes/issues/5571))
- add Port component
  ([#5568](https://github.com/portefaix/portefaix-kubernetes/issues/5568))
- Add Dragonfly application(s)
  ([#5450](https://github.com/portefaix/portefaix-kubernetes/issues/5450))
- Migrate to Traefik for Ingress and Gateway
  ([#5542](https://github.com/portefaix/portefaix-kubernetes/issues/5542))
- [Helm] Migrate some charts to OCI Artifacts
  ([#5506](https://github.com/portefaix/portefaix-kubernetes/issues/5506))
- [Helm] Migrate some charts to OCI Artifacts
  ([#5505](https://github.com/portefaix/portefaix-kubernetes/issues/5505))
- Refactoring Grafana datasources using the Grafana Operator
  ([#5459](https://github.com/portefaix/portefaix-kubernetes/issues/5459))
- Cleanup configuration using official Helm chart
  ([#5455](https://github.com/portefaix/portefaix-kubernetes/issues/5455))
- Refactoring Policy Controller
  ([#5435](https://github.com/portefaix/portefaix-kubernetes/issues/5435))
- Prometheus Operator: change label for monitoring resources
  ([#5381](https://github.com/portefaix/portefaix-kubernetes/issues/5381))
- rename sidecar labels and annotations
  ([#5386](https://github.com/portefaix/portefaix-kubernetes/issues/5386))

### 🚨 Maintenance

- **deps:** update helm release alloy to 0.7.0
  ([#5650](https://github.com/portefaix/portefaix-kubernetes/issues/5650))
- **deps:** update argo-cd docker tag to v7
  ([#5527](https://github.com/portefaix/portefaix-kubernetes/issues/5527))
- **deps:** update prometheus-operator-crds docker tag to v14
  ([#5662](https://github.com/portefaix/portefaix-kubernetes/issues/5662))
- **deps:** update kube-prometheus-stack docker tag to v62
  ([#5661](https://github.com/portefaix/portefaix-kubernetes/issues/5661))
- **deps:** update peter-evans/create-pull-request action to v7
  ([#5667](https://github.com/portefaix/portefaix-kubernetes/issues/5667))
- **deps:** update helm release homepage to 2.0.1
  ([#5659](https://github.com/portefaix/portefaix-kubernetes/issues/5659))
- **deps:** update argo-rollouts docker tag to v2.37.6
  ([#5649](https://github.com/portefaix/portefaix-kubernetes/issues/5649))
- **deps:** update helm release port-k8s-exporter to 0.2.34
  ([#5651](https://github.com/portefaix/portefaix-kubernetes/issues/5651))
- **deps:** update github/codeql-action action to v3.26.5
  ([#5640](https://github.com/portefaix/portefaix-kubernetes/issues/5640))
- **deps:** update dragonfly-operator docker tag to v1.1.7
  ([#5622](https://github.com/portefaix/portefaix-kubernetes/issues/5622))
- **deps:** update github/codeql-action action to v3.26.4
  ([#5621](https://github.com/portefaix/portefaix-kubernetes/issues/5621))
- **deps:** update github/codeql-action action to v3.26.3
  ([#5612](https://github.com/portefaix/portefaix-kubernetes/issues/5612))
- **deps:** update kube-prometheus-stack docker tag to v61
  ([#5589](https://github.com/portefaix/portefaix-kubernetes/issues/5589))
- **deps:** update prometheus-operator-crds docker tag to v13
  ([#5587](https://github.com/portefaix/portefaix-kubernetes/issues/5587))
- **deps:** update prometheus-blackbox-exporter docker tag to v9
  ([#5593](https://github.com/portefaix/portefaix-kubernetes/issues/5593))
- **deps:** update ossf/scorecard-action action to v2.4.0
  ([#5584](https://github.com/portefaix/portefaix-kubernetes/issues/5584))
- **deps:** update github/codeql-action action to v3.26.0
  ([#5579](https://github.com/portefaix/portefaix-kubernetes/issues/5579))
- **deps:** update actions/upload-artifact action to v4.3.6
  ([#5578](https://github.com/portefaix/portefaix-kubernetes/issues/5578))
- **deps:** update step-security/harden-runner action to v2.9.1
  ([#5572](https://github.com/portefaix/portefaix-kubernetes/issues/5572))
- **deps:** update opencost docker tag to v1.41.0
  ([#5567](https://github.com/portefaix/portefaix-kubernetes/issues/5567))
- **deps:** update kured docker tag to v5.5.0
  ([#5566](https://github.com/portefaix/portefaix-kubernetes/issues/5566))
- **deps:** update kargo docker tag to v0.8.3
  ([#5565](https://github.com/portefaix/portefaix-kubernetes/issues/5565))
- **deps:** update helm release pyroscope to 1.7.1
  ([#5562](https://github.com/portefaix/portefaix-kubernetes/issues/5562))
- **deps:** update helm release quickwit to 0.7.0
  ([#5563](https://github.com/portefaix/portefaix-kubernetes/issues/5563))
- **deps:** update helm release loki to 6.8.0
  ([#5559](https://github.com/portefaix/portefaix-kubernetes/issues/5559))
- **deps:** update grafana-operator docker tag to v5.11.0 - autoclosed
  ([#5547](https://github.com/portefaix/portefaix-kubernetes/issues/5547))
- **deps:** update helm release alloy to 0.6.0
  ([#5549](https://github.com/portefaix/portefaix-kubernetes/issues/5549))
- **deps:** update helm release keda to 2.15.0
  ([#5555](https://github.com/portefaix/portefaix-kubernetes/issues/5555))
- **deps:** update helm release dex to 0.19.0
  ([#5554](https://github.com/portefaix/portefaix-kubernetes/issues/5554))
- **deps:** update helm release keptn to 0.7.0
  ([#5556](https://github.com/portefaix/portefaix-kubernetes/issues/5556))
- **deps:** update github/codeql-action action to v3.25.15
  ([#5551](https://github.com/portefaix/portefaix-kubernetes/issues/5551))
- **deps:** update argo-workflows docker tag to v0.41.14
  ([#5538](https://github.com/portefaix/portefaix-kubernetes/issues/5538))
- **deps:** update step-security/harden-runner action to v2.9.0
  ([#5525](https://github.com/portefaix/portefaix-kubernetes/issues/5525))
- **deps:** update helm release keptn to 0.6.0
  ([#5175](https://github.com/portefaix/portefaix-kubernetes/issues/5175))
- **deps:** update helm release alloy to 0.5.0
  ([#5423](https://github.com/portefaix/portefaix-kubernetes/issues/5423))
- **deps:** update actions/upload-artifact action to v4.3.4
  ([#5451](https://github.com/portefaix/portefaix-kubernetes/issues/5451))
- **deps:** update github/codeql-action action to v3.25.11
  ([#5442](https://github.com/portefaix/portefaix-kubernetes/issues/5442))
- **deps:** update helm release prometheus-operator-crds to 12.0.0
  ([#5327](https://github.com/portefaix/portefaix-kubernetes/issues/5327))
- **deps:** update github/codeql-action action to v3.25.10
  ([#5405](https://github.com/portefaix/portefaix-kubernetes/issues/5405))
- **deps:** update actions/checkout action to v4.1.7
  ([#5403](https://github.com/portefaix/portefaix-kubernetes/issues/5403))
- **deps:** update github/codeql-action action to v3.25.8
  ([#5379](https://github.com/portefaix/portefaix-kubernetes/issues/5379))

## [0.56.0](https://github.com/portefaix/portefaix-kubernetes/compare/v0.55.0...v0.56.0) (2024-06-08)

### 🚧 Changes

### 🚀 Features

- Stack v2: Refactoring to use the argo-cd-apps chart
  ([#5368](https://github.com/portefaix/portefaix-kubernetes/issues/5368))
- Enable Grafana SSO
  ([#5340](https://github.com/portefaix/portefaix-kubernetes/issues/5340))
- **homepage:** Refactoring home service
  ([#5337](https://github.com/portefaix/portefaix-kubernetes/issues/5337))
- Use remote Renovate configuration from Organization
  ([#5326](https://github.com/portefaix/portefaix-kubernetes/issues/5326))
- Migrate from Nats Operator to Nats
  ([#5312](https://github.com/portefaix/portefaix-kubernetes/issues/5312))
- Nats Operator deployment
  ([#5309](https://github.com/portefaix/portefaix-kubernetes/issues/5309))
- PodInfo application managed by Kargo
  ([#5286](https://github.com/portefaix/portefaix-kubernetes/issues/5286))
- Kargo v0.6.0
  ([#5278](https://github.com/portefaix/portefaix-kubernetes/issues/5278))

### 🚨 Maintenance

- **deps:** update ghcr.io/gethomepage/homepage docker tag to v0.9.2
  ([#5361](https://github.com/portefaix/portefaix-kubernetes/issues/5361))
- **deps:** update github/codeql-action action to v3.25.7
  ([#5359](https://github.com/portefaix/portefaix-kubernetes/issues/5359))
- **deps:** update helm chart loki to v6
  ([#5254](https://github.com/portefaix/portefaix-kubernetes/issues/5254))
- **deps:** update helm chart argo-cd to v6.11.1
  ([#5313](https://github.com/portefaix/portefaix-kubernetes/issues/5313))

## [0.55.0](https://github.com/portefaix/portefaix-kubernetes/compare/v0.54.0...v0.55.0) (2024-05-17)

### 🚧 Changes

- Envoy Gateway v1.x
  ([#5197](https://github.com/portefaix/portefaix-kubernetes/issues/5197))

### 🚀 Features

- Refactoring bootstrap process
  ([#5273](https://github.com/portefaix/portefaix-kubernetes/issues/5273))
- Manage Argo-CD using Argo-CD
  ([#5270](https://github.com/portefaix/portefaix-kubernetes/issues/5270))
- migrate to Grafana Operator
  ([#5095](https://github.com/portefaix/portefaix-kubernetes/issues/5095))
- Migration to Alloy for OTLP endpoints and some Grafana dashboards
  ([#5260](https://github.com/portefaix/portefaix-kubernetes/issues/5260))
- Pyroscope observability
  ([#5256](https://github.com/portefaix/portefaix-kubernetes/issues/5256))
- Refactoring CRDs bootstrap process
  ([#5225](https://github.com/portefaix/portefaix-kubernetes/issues/5225))
- Refactoring CRD management
  ([#5224](https://github.com/portefaix/portefaix-kubernetes/issues/5224))
- Nginx json log level
  ([#5208](https://github.com/portefaix/portefaix-kubernetes/issues/5208))
- **grafana:** Logs dashboards
  ([#5207](https://github.com/portefaix/portefaix-kubernetes/issues/5207))
- Refactoring observability Grafana dashboards
  ([#5206](https://github.com/portefaix/portefaix-kubernetes/issues/5206))
- **alloy:** Migrate configuration from Agent to Allow
  ([#5136](https://github.com/portefaix/portefaix-kubernetes/issues/5136))
- Retina, the network observability component
  ([#5154](https://github.com/portefaix/portefaix-kubernetes/issues/5154))
- Prometheus Operator logs in JSON format
  ([#5163](https://github.com/portefaix/portefaix-kubernetes/issues/5163))
- Setup AWS Bedrock for K8sgpt
  ([#5151](https://github.com/portefaix/portefaix-kubernetes/issues/5151))
- Refactoring Portefaix dashboards
  ([#5160](https://github.com/portefaix/portefaix-kubernetes/issues/5160))
- upgrade to v0.5.0
  ([#5133](https://github.com/portefaix/portefaix-kubernetes/issues/5133))

### 🚨 Maintenance

- **deps:** update helm chart litmus-core to v3
  ([#5253](https://github.com/portefaix/portefaix-kubernetes/issues/5253))
- **deps:** update helm chart alloy to v0.3.0
  ([#5259](https://github.com/portefaix/portefaix-kubernetes/issues/5259))
- **deps:** update helm chart kubewarden-defaults to v2
  ([#5252](https://github.com/portefaix/portefaix-kubernetes/issues/5252))
- **deps:** update helm chart kubernetes-chaos to v3
  ([#5251](https://github.com/portefaix/portefaix-kubernetes/issues/5251))
- **deps:** update helm chart kube-aws to v3
  ([#5232](https://github.com/portefaix/portefaix-kubernetes/issues/5232))
- **deps:** update helm chart kube-azure to v3
  ([#5233](https://github.com/portefaix/portefaix-kubernetes/issues/5233))
- **deps:** update helm chart kube-gcp to v3
  ([#5234](https://github.com/portefaix/portefaix-kubernetes/issues/5234))
- **deps:** update helm chart alloy to v0.2.0
  ([#5219](https://github.com/portefaix/portefaix-kubernetes/issues/5219))
- **deps:** update helm chart grafana to v7.3.10
  ([#5204](https://github.com/portefaix/portefaix-kubernetes/issues/5204))
- **deps:** update helm chart aws-efs-csi-driver to v3
  ([#5144](https://github.com/portefaix/portefaix-kubernetes/issues/5144))
- **deps:** update helm chart cloudflare-tunnel to v0.3.0
  ([#5168](https://github.com/portefaix/portefaix-kubernetes/issues/5168))
- **deps:** update actions/add-to-project action to v1
  ([#5143](https://github.com/portefaix/portefaix-kubernetes/issues/5143))

## [0.54.0](https://github.com/portefaix/portefaix-kubernetes/compare/v0.53.0...v0.54.0) (2024-03-29)

### 🚧 Changes

### 🚀 Features

- Update version and new Grafana dashboard
  ([#5074](https://github.com/portefaix/portefaix-kubernetes/issues/5074))
- Gateway NGinx: JSon log format for Mimir, Tempo and Loki
  ([#5024](https://github.com/portefaix/portefaix-kubernetes/issues/5024))
- Refactoring profiling using Pyroscope and Grafana
  ([#4947](https://github.com/portefaix/portefaix-kubernetes/issues/4947))
- Refactoring to use v0.4.0
  ([#4934](https://github.com/portefaix/portefaix-kubernetes/issues/4934))
- Datadog agent
  ([#4933](https://github.com/portefaix/portefaix-kubernetes/issues/4933))
- Refactoring Grafana dashboards
  ([#4919](https://github.com/portefaix/portefaix-kubernetes/issues/4919))
- Grafana Operator setup
  ([#4894](https://github.com/portefaix/portefaix-kubernetes/issues/4894))
- Home Assistant application
  ([#4859](https://github.com/portefaix/portefaix-kubernetes/issues/4859))
- K8s GPT: Multiple providers support
  ([#4817](https://github.com/portefaix/portefaix-kubernetes/issues/4817))
- Quickwit for Logs and Traces
  ([#4785](https://github.com/portefaix/portefaix-kubernetes/issues/4785))
- refactoring directories
  ([#4755](https://github.com/portefaix/portefaix-kubernetes/issues/4755))

### 🐛 Bug Fixes

- **kubernetes:** Build manifests
  ([#5014](https://github.com/portefaix/portefaix-kubernetes/issues/5014))

### 📚 Documentation

- Update release labels to v0.54.0
  ([#5077](https://github.com/portefaix/portefaix-kubernetes/issues/5077))

### 🚨 Maintenance

- **deps:** update helm chart opentelemetry-operator to v0.49.1
  ([#5048](https://github.com/portefaix/portefaix-kubernetes/issues/5048))
- **deps:** update github/codeql-action action to v3.24.8
  ([#5053](https://github.com/portefaix/portefaix-kubernetes/issues/5053))
- **deps:** update helm chart datadog to v3.58.1
  ([#5054](https://github.com/portefaix/portefaix-kubernetes/issues/5054))
- **deps:** update helm chart tempo-distributed to v1.9.0
  ([#5055](https://github.com/portefaix/portefaix-kubernetes/issues/5055))
- **deps:** update ghcr.io/tarampampam/error-pages docker tag to v2.27.0
  ([#5049](https://github.com/portefaix/portefaix-kubernetes/issues/5049))
- **deps:** update helm chart trivy-operator to v0.21.0
  ([#5050](https://github.com/portefaix/portefaix-kubernetes/issues/5050))
- **deps:** update helm chart grafana-agent to v0.37.0
  ([#5044](https://github.com/portefaix/portefaix-kubernetes/issues/5044))
- **deps:** update helm chart cloudnative-pg to v0.20.2
  ([#5043](https://github.com/portefaix/portefaix-kubernetes/issues/5043))
- **deps:** update helm chart quickwit to v0.5.8
  ([#5030](https://github.com/portefaix/portefaix-kubernetes/issues/5030))
- **deps:** update helm chart k8sgpt-operator to v0.1.1
  ([#5037](https://github.com/portefaix/portefaix-kubernetes/issues/5037))
- **deps:** update helm chart grafana to v7.3.4
  ([#5013](https://github.com/portefaix/portefaix-kubernetes/issues/5013))
- **deps:** update helm chart argo-cd to v6
  ([#4990](https://github.com/portefaix/portefaix-kubernetes/issues/4990))
- **deps:** update helm chart kube-prometheus-stack to v57
  ([#5012](https://github.com/portefaix/portefaix-kubernetes/issues/5012))
- **deps:** update helm chart prometheus-operator-crds to v9
  ([#4994](https://github.com/portefaix/portefaix-kubernetes/issues/4994))
- **deps:** update jupyterhub/action-k3s-helm action to v4
  ([#5000](https://github.com/portefaix/portefaix-kubernetes/issues/5000))
- **deps:** update peter-evans/create-pull-request action to v6
  ([#5001](https://github.com/portefaix/portefaix-kubernetes/issues/5001))
- **deps:** update release-drafter/release-drafter action to v6
  ([#5002](https://github.com/portefaix/portefaix-kubernetes/issues/5002))
- **deps:** update helm chart traefik to v26
  ([#4998](https://github.com/portefaix/portefaix-kubernetes/issues/4998))
- **deps:** update helm chart velero to v6
  ([#4999](https://github.com/portefaix/portefaix-kubernetes/issues/4999))
- **deps:** update helm chart authentik to v2024
  ([#4991](https://github.com/portefaix/portefaix-kubernetes/issues/4991))
- **deps:** update helm chart pyroscope-mixin to v1
  ([#4996](https://github.com/portefaix/portefaix-kubernetes/issues/4996))
- **deps:** update helm chart prometheus-snmp-exporter to v5
  ([#4995](https://github.com/portefaix/portefaix-kubernetes/issues/4995))
- **deps:** update helm chart falco to v4
  ([#4992](https://github.com/portefaix/portefaix-kubernetes/issues/4992))
- **deps:** update github/codeql-action action to v3
  ([#4988](https://github.com/portefaix/portefaix-kubernetes/issues/4988))
- **deps:** update pre-commit hook adrienverge/yamllint to v1.35.1
  ([#4985](https://github.com/portefaix/portefaix-kubernetes/issues/4985))
- **deps:** update actions/upload-artifact action to v4
  ([#4986](https://github.com/portefaix/portefaix-kubernetes/issues/4986))
- **deps:** update grafana/beyla docker tag to v1.3.3
  ([#4965](https://github.com/portefaix/portefaix-kubernetes/issues/4965))
- **deps:** update dependency ruff to ^0.3.0
  ([#4964](https://github.com/portefaix/portefaix-kubernetes/issues/4964))
- **deps:** update actions/add-to-project action to v0.6.0
  ([#4963](https://github.com/portefaix/portefaix-kubernetes/issues/4963))
- **deps:** update kubescape/github-action action to v3.0.4
  ([#4962](https://github.com/portefaix/portefaix-kubernetes/issues/4962))
- **deps:** update pre-commit hook compilerla/conventional-pre-commit to v3.1.0
  ([#4869](https://github.com/portefaix/portefaix-kubernetes/issues/4869))
- **deps:** update helm chart tempo-distributed to v1.7.5
  ([#4790](https://github.com/portefaix/portefaix-kubernetes/issues/4790))
- **deps:** update helm chart grafana to v7.1.0
  ([#4797](https://github.com/portefaix/portefaix-kubernetes/issues/4797))
- **deps:** update github/codeql-action action to v2.23.0
  ([#4786](https://github.com/portefaix/portefaix-kubernetes/issues/4786))

## [0.53.0](https://github.com/portefaix/portefaix-kubernetes/releases/tag/v0.53.0) (2023-12-29)

### 🚧 Changes

### 🚀 Features

- Argo-CD ApplicationSet for Core stack
  ([#4741](https://github.com/portefaix/portefaix-kubernetes/issues/4741))
- Argo-CD ApplicationSet for Security stack
  ([#4740](https://github.com/portefaix/portefaix-kubernetes/issues/4740))
- Argo-CD ApplicationSet for Chaos stack
  ([#4742](https://github.com/portefaix/portefaix-kubernetes/issues/4742))
- Argo-CD ApplicationSet for Observability stack
  ([#4739](https://github.com/portefaix/portefaix-kubernetes/issues/4739))
- Argo-CD ApplicationSet for Networking stack
  ([#4738](https://github.com/portefaix/portefaix-kubernetes/issues/4738))
- Argo-CD ApplicationSet for Storage stack
  ([#4737](https://github.com/portefaix/portefaix-kubernetes/issues/4737))
- Argo-CD ApplicationSet for System stack
  ([#4734](https://github.com/portefaix/portefaix-kubernetes/issues/4734))
- Argo-CD ApplicationSet for Tools stack
  ([#4733](https://github.com/portefaix/portefaix-kubernetes/issues/4733))
- Argo customization
  ([#4720](https://github.com/portefaix/portefaix-kubernetes/issues/4720))
- Argo-CD dashboards
  ([#4713](https://github.com/portefaix/portefaix-kubernetes/issues/4713))
- Precommit cleanup
  ([#4706](https://github.com/portefaix/portefaix-kubernetes/issues/4706))
- k3s monitoring using kube-prometheus-stack
  ([#4684](https://github.com/portefaix/portefaix-kubernetes/issues/4684))
- Change Grafana namespace
  ([#4657](https://github.com/portefaix/portefaix-kubernetes/issues/4657))

### 🐛 Bug Fixes

- k3s monitoring using kube-prometheus-stack
  ([#4684](https://github.com/portefaix/portefaix-kubernetes/issues/4684))

### 🚨 Maintenance

- Update github/codeql-action action to v2.22.11
  ([#4692](https://github.com/portefaix/portefaix-kubernetes/issues/4692))
- Update Helm chart grafana to v7.0.14
  ([#4672](https://github.com/portefaix/portefaix-kubernetes/issues/4672))
- Update Helm chart loki to v5.40.1
  ([#4670](https://github.com/portefaix/portefaix-kubernetes/issues/4670))
- Update kubescape/github-action action to v3
  ([#4666](https://github.com/portefaix/portefaix-kubernetes/issues/4666))
- Update alpine Docker tag to v3.19
  ([#4667](https://github.com/portefaix/portefaix-kubernetes/issues/4667))

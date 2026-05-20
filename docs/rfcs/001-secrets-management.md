---
rfc: 001
status: ✅ accepted
deciders:
date: 2023-08-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 001 - Secrets Management Strategy

## 1. 📝 Summary

This RFC proposes evaluating and selecting a new secrets management solution for Portefaix Kubernetes clusters to replace the current Kubeseal-based approach. The current manual process is not scalable and error-prone. We need to evaluate several alternatives that can integrate with our multi-cloud secret managers (AWS Secrets Manager, Google Cloud Secret Manager, Azure Key Vault, Scaleway Secret Manager, Akeyless, and HashiCorp Vault) and provide automated, reliable secret synchronization to Kubernetes.

**This RFC seeks feedback on which approach would best serve our needs.**

## 2. 🎯 Motivation

### Current State

Portefaix currently uses Kubeseal for managing secrets in Kubernetes applications. The workflow requires:

1. Storing secrets in a cloud secret manager (AWS, GCP, Azure, etc.)
2. Connecting to the Kubernetes cluster for each environment
3. Generating sealed secrets using the Kubeseal CLI
4. Manually updating deployment values

### Problems with Current Approach

- **Not Scalable:** Multiple manual operations required for each secret across multiple environments
- **Error-Prone:** Frequent errors related to namespace names, secret names, and environments
- **Operational Overhead:** Significant time spent on repetitive secret management tasks
- **Limited Automation:** Difficult to integrate into CI/CD pipelines
- **No Dynamic Updates:** Secrets don't automatically refresh when changed in source systems
- **Disconnect from Cloud:** Already using cloud secret managers but not leveraging them effectively

### Why Now?

- Team is experiencing increasing pain points with manual secret management
- Multi-cloud deployments are expanding (AWS, GCP, Azure, Scaleway)
- Several mature solutions have emerged in the ecosystem
- Need to improve operational efficiency and reduce errors

### Expected Benefits

Any solution we choose should provide:

- **Automated Synchronization:** Secrets automatically sync from cloud secret managers
- **Reduced Errors:** Eliminate manual generation and configuration mistakes
- **Cloud-Native Integration:** Native integration with multiple cloud secret managers
- **Scalability:** Handle secrets across multiple clusters and environments efficiently
- **Security:** Improved audit trail and access control through cloud IAM
- **Developer Experience:** Simpler, more intuitive workflow for application teams

## 3. 📖 Guide-level Explanation

### Desired Workflow

We want to enable the following workflow for application teams:

1. **Store Secret in Cloud Provider:**

   ```bash
   # Store secret in AWS Secrets Manager, GCP Secret Manager, etc.
   aws secretsmanager create-secret \
     --name prod/my-app/db-password \
     --secret-string 'mysecretpassword'
   ```

2. **Declare Secret Need in Kubernetes:**

   ```yaml
   # Application team creates a resource that references the cloud secret
   # The details will vary by solution, but the concept is the same
   apiVersion: <solution-api>
   kind: <SecretReference>
   metadata:
     name: my-app-secrets
     namespace: my-app
   spec:
     # Reference to cloud secret manager secret
     secretRef: prod/my-app/db-password
   ```

3. **Automatic Secret Creation:**
   - Solution automatically creates and maintains a Kubernetes secret
   - Secret is kept in sync with the cloud secret manager
   - Application uses the secret as normal

4. **Automatic Updates:**
   - When cloud secret is updated, Kubernetes secret is automatically refreshed
   - No manual intervention required

### Comparison with Current Approach

**Current (Kubeseal):**

```bash
# 1. Manually connect to cluster
kubectl config use-context prod-cluster

# 2. Create sealed secret (manual, error-prone)
echo -n 'mypassword' | kubeseal \
  --controller-name=sealed-secrets \
  --controller-namespace=kube-system \
  --format yaml > sealed-secret.yaml

# 3. Apply sealed secret
kubectl apply -f sealed-secret.yaml

# 4. If secret changes, repeat all steps manually
```

**Desired (Automated):**

```bash
# 1. Update secret in cloud provider
aws secretsmanager update-secret \
  --secret-id prod/my-app/db-password \
  --secret-string 'newpassword'

# 2. Wait for automatic sync
# Secret automatically updates in Kubernetes (no manual steps!)
```

## 4. 🔬 Reference-level Explanation

### High-Level Architecture

Any solution we adopt should follow this general architecture:

```
┌─────────────────────┐
│  Cloud Secret       │
│  Managers           │
│  - AWS SM           │
│  - GCP SM           │
│  - Azure KV         │
│  - Vault            │
│  - Scaleway SM      │
│  - Akeyless         │
└──────────┬──────────┘
           │
           │ Authenticated API Calls
           │
           ▼
┌─────────────────────┐
│  Secrets Sync       │
│  Solution           │
│  (Operator/Driver)  │
└──────────┬──────────┘
           │
           │ Create/Update
           │
           ▼
┌─────────────────────┐
│  Kubernetes         │
│  Secrets            │
└─────────────────────┘
```

### Technical Requirements

1. **Multi-Cloud Support:** Must support AWS, GCP, Azure, Scaleway, and Vault
2. **Authentication:** Must support cloud-native authentication (IRSA, Workload Identity, Managed Identity)
3. **Namespace Isolation:** Must support proper multi-tenancy in shared clusters
4. **Refresh Mechanism:** Must support periodic secret refresh
5. **Monitoring:** Must expose metrics and status for observability
6. **GitOps Compatible:** Must work well with our GitOps workflow (Argo CD)
7. **Minimal App Changes:** Ideally, applications continue using standard Kubernetes secrets

### Evaluation Criteria

We will evaluate each solution against:

1. **Functionality:** Does it support all our cloud providers?
2. **Maturity:** Is it production-ready? Active community?
3. **Operational Complexity:** How difficult to deploy and maintain?
4. **Security:** Does it follow security best practices?
5. **Migration Path:** How easy to migrate from Kubeseal?
6. **Performance:** Can it handle our scale?
7. **Cost:** Any licensing or operational costs?
8. **Vendor Lock-in:** Can we switch solutions later if needed?

## 5. Drawbacks

### General Trade-offs

Any solution we choose will have these drawbacks compared to Kubeseal:

**Operational Complexity:**

- Additional component to deploy, maintain, and monitor
- Learning curve for teams to understand new concepts
- More complex debugging (need to check IAM, network, sync status)

**External Dependencies:**

- Requires cloud provider APIs to be available
- Requires proper IAM/service account configuration
- Requires network connectivity to cloud APIs

**Migration Effort:**

- Significant work to migrate all existing sealed secrets
- Period where both old and new systems coexist
- Training required for all teams

**Potential Issues:**

- API rate limiting from cloud providers
- Additional API costs (likely minimal but should be tracked)
- Different behaviors across cloud providers

## 6. Alternatives

### Option 1: External Secrets Operator (ESO)

**Overview:** CNCF Sandbox project that syncs secrets from external secret management systems to Kubernetes secrets.

**How It Works:**

- Introduces `ExternalSecret` CRD to define which secrets to fetch
- Introduces `SecretStore`/`ClusterSecretStore` CRD for authentication
- Controller watches ExternalSecrets and creates/updates Kubernetes secrets

**Example:**

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: aws-secrets-manager
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-west-2
      auth:
        jwt:
          serviceAccountRef:
            name: external-secrets-sa
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: my-app-secrets
spec:
  secretStoreRef:
    name: aws-secrets-manager
    kind: ClusterSecretStore
  target:
    name: my-app-secrets
  data:
    - secretKey: password
      remoteRef:
        key: prod/my-app/db-password
```

**Pros:**

- ✅ **Broad Provider Support:** AWS, GCP, Azure, Vault, Akeyless, and 20+ other providers
- ✅ **CNCF Project:** Sandbox status, active community, growing adoption
- ✅ **Flexible:** Supports both cluster-wide and namespace-scoped secret stores
- ✅ **Template Support:** Can transform and combine secrets
- ✅ **Mature:** Production-ready with good documentation

**Cons:**

- 🚫 **Additional CRDs:** Teams need to learn new Kubernetes resources
- 🚫 **Complexity:** More moving parts than simpler solutions
- 🚫 **CNCF Sandbox:** Not yet graduated or incubating status

**Links:**

- Website: https://external-secrets.io/
- GitHub: https://github.com/external-secrets/external-secrets
- CNCF: https://www.cncf.io/projects/external-secrets/

---

### Option 2: Vault Secrets Operator (VSO)

**Overview:** Official HashiCorp operator for syncing Vault secrets to Kubernetes.

**How It Works:**

- Focuses exclusively on Vault integration
- Introduces `VaultStaticSecret` and `VaultDynamicSecret` CRDs
- Controller authenticates to Vault and creates Kubernetes secrets

**Example:**

```yaml
apiVersion: secrets.hashicorp.com/v1beta1
kind: VaultAuth
metadata:
  name: vault-auth
spec:
  method: kubernetes
  mount: kubernetes
  kubernetes:
    role: my-app
    serviceAccount: default
---
apiVersion: secrets.hashicorp.com/v1beta1
kind: VaultStaticSecret
metadata:
  name: my-app-secrets
spec:
  vaultAuthRef: vault-auth
  mount: secret
  path: prod/my-app
  destination:
    name: my-app-secrets
    create: true
```

**Pros:**

- ✅ **Official HashiCorp Product:** Well-supported and maintained
- ✅ **Deep Vault Integration:** Best-in-class Vault support
- ✅ **Dynamic Secrets:** Supports Vault dynamic secrets (DB credentials, etc.)
- ✅ **Strong Security Model:** Leverages Vault's security features

**Cons:**

- 🚫 **Vault Only:** Requires using Vault for ALL secrets (no direct cloud provider integration)
- 🚫 **Infrastructure Requirement:** Must run and maintain Vault clusters
- 🚫 **Indirect Access:** Need Vault as intermediary for cloud secrets
- 🚫 **Operational Overhead:** Additional infrastructure to manage

**Links:**

- Website: https://developer.hashicorp.com/vault/docs/platform/k8s/vso
- GitHub: https://github.com/hashicorp/vault-secrets-operator

---

### Option 3: Secrets Store CSI Driver

**Overview:** Kubernetes CSI driver that mounts secrets from external stores as volumes.

**How It Works:**

- Implements Container Storage Interface for secrets
- Mounts secrets as files in pod volumes
- Supports AWS, Azure, GCP, and Vault via provider plugins

**Example:**

```yaml
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: aws-secrets
spec:
  provider: aws
  parameters:
    objects: |
      - objectName: "prod/my-app/db-password"
        objectType: "secretsmanager"
---
apiVersion: v1
kind: Pod
metadata:
  name: my-app
spec:
  volumes:
    - name: secrets
      csi:
        driver: secrets-store.csi.k8s.io
        volumeAttributes:
          secretProviderClass: aws-secrets
  containers:
    - name: app
      volumeMounts:
        - name: secrets
          mountPath: "/mnt/secrets"
          readOnly: true
```

**Pros:**

- ✅ **Official Kubernetes Project:** SIG-managed project
- ✅ **Cloud Provider Support:** Good support for AWS, Azure, GCP
- ✅ **Volume-based:** Secrets are files, can be watched for changes
- ✅ **Minimal Cluster State:** Secrets can exist only in pods, not etcd

**Cons:**

- 🚫 **Not Kubernetes Secrets:** Applications must read files, not use Secret API
- 🚫 **Application Changes:** Requires modifying apps to read from files
- 🚫 **Volume Management:** More complex pod specifications
- 🚫 **Limited Features:** Less flexible than operator-based solutions

**Links:**

- Website: https://secrets-store-csi-driver.sigs.k8s.io/
- GitHub: https://github.com/kubernetes-sigs/secrets-store-csi-driver

---

### Option 4: Infisical

**Overview:** Modern secret management platform with Kubernetes operator.

**How It Works:**

- Centralized secret management platform (self-hosted or SaaS)
- Kubernetes operator syncs secrets to clusters
- Provides UI for secret management and comparison

**Example:**

```yaml
apiVersion: secrets.infisical.com/v1alpha1
kind: InfisicalSecret
metadata:
  name: my-app-secrets
spec:
  hostAPI: https://app.infisical.com/api
  authentication:
    serviceToken:
      secretsScope:
        projectSlug: my-project
        envSlug: production
  managedSecretReference:
    secretName: my-app-secrets
    secretNamespace: my-app
```

**Pros:**

- ✅ **User-Friendly UI:** Great interface for managing and visualizing secrets
- ✅ **Cross-Environment Comparison:** Shows secret differences across environments
- ✅ **Developer-Focused:** Good developer experience
- ✅ **Multi-Cloud:** Can integrate with cloud secret managers

**Cons:**

- 🚫 **Enterprise License:** RBAC and SSO require enterprise license
- 🚫 **Additional Platform:** Another system to deploy and maintain
- 🚫 **Less Mature:** Smaller community compared to other options
- 🚫 **Centralized:** Requires Infisical platform to be running

**Links:**

- Website: https://infisical.com/
- GitHub: https://github.com/Infisical/infisical

---

### Option 5: Keep Kubeseal (Status Quo)

**Overview:** Continue using our current Kubeseal-based approach.

**How It Works:**

- Sealed secrets encrypted and stored in Git
- Sealed Secrets controller decrypts them in-cluster
- Manual process to create and update sealed secrets

**Pros:**

- ✅ **Already Deployed:** No migration needed
- ✅ **Team Familiarity:** Teams already understand it
- ✅ **Simple Model:** Encrypted secrets in Git, clear workflow
- ✅ **GitOps Native:** Fits well with GitOps approach

**Cons:**

- 🚫 **Manual Operations:** Doesn't solve our scaling problem
- 🚫 **Error-Prone:** Continues current pain points
- 🚫 **No Cloud Integration:** Can't leverage cloud secret manager features
- 🚫 **No Automation:** Difficult to automate secret updates

## 7. Unresolved Questions

**We need your input on the following questions:**

1. **Which solution best fits our needs?** Based on the options above, which do you think we should adopt?

2. **Migration Strategy:** Should we:
   - Migrate everything at once (big bang)?
   - Pilot with a few applications first?
   - Gradually migrate application by application?

3. **SecretStore Strategy:** Should we:
   - Use cluster-wide stores for everything?
   - Use namespace-scoped stores for isolation?
   - Mix both approaches based on use case?

4. **Refresh Intervals:** What should be the default secret refresh interval?
   - More frequent = fresher secrets but more API calls
   - Less frequent = fewer API calls but staler secrets

5. **Vault's Role:** Do we want to:
   - Use Vault as a central hub for all secrets (supports VSO)?
   - Use cloud-native secret managers directly (supports ESO/CSI)?
   - Mix both approaches?

6. **Backup/DR Strategy:** How do we handle disaster recovery scenarios?
   - What if both cloud secret manager AND cluster are lost?
   - Do we need secrets backed up separately?

7. **Multi-Tenancy:** How do we ensure proper isolation in shared clusters?
   - Namespace-scoped access controls?
   - Separate secret stores per team?

8. **Cost Considerations:** Are we concerned about:
   - API call costs to cloud secret managers?
   - Enterprise licensing (for solutions like Infisical)?

9. **Application Changes:** Are we willing to:
   - Require applications to read files (CSI approach)?
   - Or prefer solutions that create Kubernetes secrets (operator approach)?

## 8. Future Possibilities

Once we have a solution in place, we could explore:

### Short Term

- Automated secret rotation workflows
- Integration with policy engines (OPA/Kyverno) to enforce secret usage patterns
- Standardized templates for common secret patterns
- Automated migration tools from Kubeseal to new solution

### Long Term

- Secret versioning and rollback capabilities
- Automated secret lifecycle management (creation, rotation, deletion)
- Cross-cluster secret synchronization
- Secret analytics and usage tracking
- Compliance reporting for secret access

## Next Steps

1. We will discuss responses during the next architecture meeting
2. Create a detailed evaluation matrix comparing the top 2-3 options
3. Potentially run proof-of-concept deployments
4. Create an ADR documenting the final decision
5. Develop migration plan and timeline

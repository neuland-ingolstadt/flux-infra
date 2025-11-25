# FluxCD GitOps Cluster

This repository contains the Flux configuration that manages the
infrastructure and applications of the cluster using GitOps. Any change
that lands on the `main` branch is reconciled by Flux and applied to the
cluster automatically.

## 🛠️ Setup & Tools

### Windows Installation

```powershell
# Install Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install GO
winget install --id=GoLang.Go -e

# Install FluxCD, kubectl and k9s
winget install -e --id FluxCD.Flux
winget install -e --id Kubernetes.kubectl
scoop install k9s
```

## 🔐 Managing Secrets

We use [SOPS](https://github.com/mozilla/sops) to manage secrets.
Visit our [sops-infra](https://github.com/neuland-ingolstadt/sops-infra) repository for more information.

## ⚡ Common Operations

### Force Immediate Reconciliation

```bash
flux reconcile kustomization flux-system --with-source
```

### Update Source and Apply Latest Manifests

```bash
flux reconcile source git flux-system && \
  flux reconcile kustomization flux-system
```

### Check Cluster Health

```bash
flux check --pre
flux get all
```

### Monitor Logs

```bash
flux logs --kind Kustomization -n flux-system
```

### Suspend and Resume Kustomizations

```bash
flux suspend kustomization <name> -n flux-system
flux resume kustomization <name> -n flux-system
```

### Cluster Management UI

```bash
k9s  # Terminal-based Kubernetes UI
```

## 🧑🏼‍💻 Cluster Bootstrap

### Install Flux on Fresh Cluster

Install Flux on a fresh Kubernetes cluster and point it at this
repository. The command below installs the Flux controllers and
configures them to sync from this Git repository:

```bash
flux bootstrap git \
  --url=https://github.com/your-org/flux-infra \
  --branch=main \
  --path=clusters/cluster
```

Once bootstrapping completes, push any manifest changes to the
`clusters/clust

## Kubernetes CLI

[k9s](https://k9scli.io/) provides a terminal-based UI for managing your Kubernetes clusters. Install it via Homebrew:

```bash
brew install k9s
```

Launch the interface with `k9s` and navigate your cluster resources using
the arrow keys. Press `ctrl+c` to quit the program.

## Capacitor Dashboard

Capacitor offers a lightweight web interface for monitoring Flux events
and inspecting the deployed resources. The dashboard runs locally and
requires no installation besides fetching the binary.

```bash
curl -L "https://github.com/gimlet-io/capacitor/releases/download/capacitor-next/next-$(uname)-$(uname -m)" -o next
chmod +x next
```

```bash
./next --port 3333
```
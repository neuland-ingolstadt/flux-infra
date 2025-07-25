# FluxCD GitOps Cluster

This repository contains the Flux configuration that manages the
infrastructure and applications of the cluster using GitOps. Any change
that lands on the `main` branch is reconciled by Flux and applied to the
cluster automatically.

## Useful Commands

A few handy Flux commands when operating the cluster:

```bash
flux reconcile kustomization flux-system --with-source
```

Check the status of all Flux objects:

```bash
flux get all
```

Verify that all controllers are healthy:

```bash
flux check --pre
```

Tail the logs of the Flux controllers:

```bash
flux logs --kind Kustomization -n flux-system
```

Update a source and apply the latest manifests:

```bash
flux reconcile source git flux-system && \
  flux reconcile kustomization flux-system
```

Suspend and resume a specific Kustomization:

```bash
flux suspend kustomization <name> -n flux-system
flux resume kustomization <name> -n flux-system
```

Bootstrapping a cluster

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
# Fleet Infra

## Capacitor Dashboard

```bash
curl -L "https://github.com/gimlet-io/capacitor/releases/download/capacitor-next/next-$(uname)-$(uname -m)" -o next
chmod +x next
```

```bash
./next --port 3333
```
## Useful Commands

Reconcile the Flux system to apply the latest changes:

```bash
flux reconcile kustomization flux-system --with-source
```
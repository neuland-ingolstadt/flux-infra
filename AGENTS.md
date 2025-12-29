# Repository Guidelines

## Project Structure & Module Organization
- `clusters/cluster` holds FluxCD reconciliation entry points (`flux-system/`, `kustomization.yaml`) and app manifests under `apps/`.
- `infrastructure/controllers` and `infrastructure/configs` contain cluster-wide controllers and shared config (certs, issuers, MetalLB, Longhorn, etc.).

## Build, Test, and Development Commands
- `kustomize build clusters/cluster` renders the full cluster manifests locally for review.
- `kubectl kustomize clusters/cluster` is an alternative renderer if you rely on kubectl’s built-in kustomize.
- `yamlfmt .` formats YAML using `.yamlfmt.yaml` (2-space indent).
- FluxCD applies changes from `main` to the k3s cluster; local apply/dry-run requires cluster access and is typically done via the internal runbook.

## Coding Style & Naming Conventions
- YAML uses 2-space indentation; keep lines unwrapped (see `.yamlfmt.yaml`).
- Prefer clear, resource-type filenames: `deployment.yaml`, `service.yaml`, `ingress.yaml`, `kustomization.yaml`.
- Use lowercase with hyphens for directory and resource names (e.g., `neuland-app`, `verein-ext`).

## Testing Guidelines
- No automated test suite is present in this repo.
- Validate manifest changes by rendering with `kustomize build` and reviewing diffs before merging.
- For cluster-validated changes, follow the internal runbook and use `kubectl apply --dry-run=server -k ...` where appropriate.

## Commit & Pull Request Guidelines
- Commit history follows Conventional Commits (e.g., `chore(monitoring): ...`, `feat(deployment): ...`).
- PRs should include: a concise summary, impacted paths (e.g., `clusters/cluster/apps/...`), and any rollout/rollback notes.
- Link related issues/incidents and call out user-visible changes or operational risk.

## Security & Configuration Tips
- Do not commit secrets; SOPS-managed secrets live in the separate `sops-infra` repo.
- Any change to `main` is reconciled automatically by FluxCD, so validate intent carefully before merge.

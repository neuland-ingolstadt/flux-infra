# FluxCD GitOps Cluster

This repository contains the Flux configuration that manages the
infrastructure and applications of the cluster using GitOps. Any change
that lands on the `main` branch is reconciled by Flux and applied to the
cluster automatically via webhooks. The commit status shows the status of the reconciliation.

## 🛠️ Setup & Tooling

All installation steps for Flux, kubectl, k9s, and other required tooling
are covered in our internal runbook. Please follow the guide in the
Neuland knowledge base to provision your environment and gain access to
the cluster.

## 🔐 Secrets & GitOps Operations

Procedures for SOPS usage, secret rotation, Flux reconciliation,
emergency fixes, and general day-to-day operations are consolidated in
the internal documentation. Always consult the runbook before applying
changes so you stay aligned with our platform standards.


## Internal Documentation

You can find the full operational and onboarding guide here:
https://notes.neuland-ingolstadt.de/doc/neuland-kubernetes-PNe783ueEJ

## SOPS Repository

The SOPS repository is used to store the secrets for the cluster. It is located at https://github.com/neuland-ingolstadt/sops-infra.

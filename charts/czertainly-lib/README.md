# Chart Library - CZERTAINLY

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) library as part of the CZERTAINLY platform.
The library groups the common logic that can be applied across all Helm charts.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.8.0+

## Using this Chart

**Include the library in `chart.yaml`**

Include the dependency into your target `chart.yaml`:
```yaml
dependencies:
  - name: czertainly-lib
    version: 0.2.0
    repository: oci://harbor.3key.company/czertainly-helm/czertainly-helm
```

**Update dependencies**

Once the dependency is configured, update chart dependencies to apply the changes
```bash
helm dependency update
```

## Templates

The following templates are available:

| Identifier                                             | Description                                                                                                                                               |
|--------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| `czertainly-lib.trusted.certificates.secret.tpl`       | Template for the secret containing global additional trusted CA certificates applied for all sub-charts. The secret name is static `trusted-certificates` |
| `czertainly-lib.trusted.certificates.secret.local.tpl` | Template for the secret containing local additional trusted CA certificates applied for all sub-charts                                                    |
| `czertainly-lib.trusted.certificates.secret.global`    | Static template for the secret containing trusted certificates                                                                                            |

## Functions

The following functions are defined:

| Identifier                                         | Description                                                                      |
|----------------------------------------------------|----------------------------------------------------------------------------------|
| `czertainly-lib.trusted.certificates.secret`       | Prepares the `trusted-certificates` secret                                       |
| `czertainly-lib.trusted.certificates.secret.local` | Prepares local secret with additionally trusted certificates                     |
| `czertainly-lib.util.merge`                        | Merge two templates to one yaml                                                  |
| `czertainly-lib.util.format.jdbcUrl`               | Format the JDBC URL connection string based in the database configuration values |
| `czertainly-lib.util.format.netUrl`                | Format the .NET URL connection string based in the database configuration values |
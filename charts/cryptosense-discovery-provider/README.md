# Cryptosense Discovery Provider - CZERTAINLY

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.8.0+
- PostgreSQL 11+

## Using this Chart

### Installation

**Create namespace**

We’ll need to define a Kubernetes namespace where the resources created by the Chart should be installed:
```bash
kubectl create namespace czertainly
```

**Create `values.yaml`**

> **Note**
> You can also use `--set` options for the helm to apply configuration for the chart.

Copy the default `values.yaml` from the Helm chart and modify the values accordingly:
```bash
helm show values oci://harbor.3key.company/czertainly-helm/cryptosense-discovery-provider > values.yaml
```
Now edit the `values.yaml` according to your desired stated, see [Configurable parameters](#configurable-parameters) for more information.

**Install**

For the basic installation, run:
```bash
helm install --namespace czertainly -f values.yaml czertainly-cryptosense-discovery-provider oci://harbor.3key.company/czertainly-helm/cryptosense-discovery-provider
```

**Save your configuration**

Always make sure you save the `values.yaml` and all `--set` and `--set-file` options you used. You will need to use the same options when you upgrade to new versions with Helm. In case you are changing the configuration, save the new configuration.

### Upgrade

> **Warning**
> Be sure that you always save your previous configuration!

For upgrading the installation, update your configuration and run:
```bash
helm upgrade --namespace czertainly -f values.yaml czertainly-cryptosense-discovery-provider oci://harbor.3key.company/czertainly-helm/cryptosense-discovery-provider
```

### Uninstall

You can use the `helm uninstall` command to uninstall the application:
```bash
helm uninstall --namespace czertainly czertainly-cryptosense-discovery-provider
```

## Configurable parameters

You can find current values in the [values.yaml](values.yaml).
You can also Specify each parameter using the `--set` or `--set-file` argument to `helm install`.

### Global parameters

Global values are used to define common parameters for the chart and all its sub-charts by exactly the same name.

| Parameter                   | Default value | Description                                                                       |
|-----------------------------|---------------|-----------------------------------------------------------------------------------|
| global.imagePullSecrets     | `[]`          | Name of the registered credential as a secret to access private CZERTAINLY images |
| global.database.type        | `""`          | Type of the database, currently only `postgresql` is supported                    |
| global.database.host        | `""`          | Host where is the database located                                                |
| global.database.port        | `""`          | Port on which is the database listening                                           |
| global.database.name        | `""`          | Database name                                                                     |
| global.database.username    | `""`          | Username to access the database                                                   |
| global.database.password    | `""`          | Password to access the database                                                   |
| global.httpProxy            | `""`          | Proxy to be used to access external resources through http                        |
| global.httpsProxy           | `""`          | Proxy to be used to access external resources through https                       |
| global.noProxy              | `""`          | Defines list of external resources that should not use proxy settings             |

### Local parameters

The following values may be configured:

| Parameter            | Default value            | Description                                                                       |
|----------------------|--------------------------|-----------------------------------------------------------------------------------|
| imagePullSecrets     | `[]`                     | Name of the registered credential as a secret to access private CZERTAINLY images |
| database.type        | `"postgresql"`           | Type of the database, currently only `postgresql` is supported                    |
| database.host        | `"host.docker.internal"` | Host where is the database located                                                |
| database.port        | `5432`                   | Port on which is the database listening                                           |
| database.name        | `"czertainlydb"`         | Database name                                                                     |
| database.username    | `"czertainlyuser"`       | Username to access the database                                                   |
| database.password    | `"your-strong-password"` | Password to access the database                                                   |
| httpProxy            | `""`                     | Proxy to be used to access external resources through http                        |
| httpsProxy           | `""`                     | Proxy to be used to access external resources through https                       |
| httpProxy            | `""`                     | Defines list of external resources that should not use proxy settings             |
| logging.level        | `"INFO"`                 | Allowed values are `"INFO"`, `"DEBUG"`, `"WARN"`, `"TRACE"`                       |
| service.type         | `"ClusterIP"`            | Type of the service that is exposed                                               |
| service.port         | `8080`                   | Port number of the exposed service                                                |

### Additional parameters

Additional parameters may be found in the [values.yaml](values.yaml) and dependencies.
See dependent charts for the description of available parameters.
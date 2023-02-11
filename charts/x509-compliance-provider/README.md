# X509 Compliance Provider - CZERTAINLY

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.8.0+

## Using this Chart

### Installation

**Add Helm chart repository**

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
helm show values oci://harbor.3key.company/czertainly-helm/x509-compliance-provider > values.yaml
```
Now edit the `values.yaml` according to your desired stated, see [Configurable parameters](#configurable-parameters) for more information.

**Install**

For the basic installation, run:
```bash
helm install --namespace czertainly -f values.yaml czertainly-x509-compliance-provider oci://harbor.3key.company/czertainly-helm/x509-compliance-provider
```

**Save your configuration**

Always make sure you save the `values.yaml` and all `--set` and `--set-file` options you used. You will need to use the same options when you upgrade to new versions with Helm. In case you are changing the configuration, save the new configuration.

### Upgrade

> **Warning**
> Be sure that you always save your previous configuration!

For upgrading the installation, update your configuration and run:
```bash
helm upgrade --namespace czertainly -f values.yaml czertainly-x509-compliance-provider oci://harbor.3key.company/czertainly-helm/x509-compliance-provider
```

### Uninstall

You can use the `helm uninstall` command to uninstall the application:
```bash
helm uninstall --namespace czertainly czertainly-x509-compliance-provider
```

## Configurable parameters

You can find current values in the [values.yaml](values.yaml).
You can also Specify each parameter using the `--set` or `--set-file` argument to `helm install`.

### Global parameters

Global values are used to define common parameters for the chart and all its sub-charts by exactly the same name.

| Parameter                | Default value | Description                                 |
|--------------------------|---------------|---------------------------------------------|
| global.image.registry    | `""`          | Global docker registry name                 |
| global.image.pullSecrets | `[]`          | Global array of secret names for image pull |

### Local parameters

The following values may be configured:

| Parameter         | Default value                                     | Description                                                 |
|-------------------|---------------------------------------------------|-------------------------------------------------------------|
| image.registry    | `docker.io`                                       | Docker registry name for the image                          |
| image.repository  | `3keycompany/czertainly-x509-compliance-provider` | Docker image repository name                                |
| image.tag         | `1.1.0`                                           | Docker image tag                                            |
| image.digest      | `""`                                              | Docker image digest, will override tag if specified         |
| image.pullPolicy  | `IfNotPresent`                                    | Image pull policy                                           |
| image.pullSecrets | `[]`                                              | Array of secret names for image pull                        |
| logging.level     | `"INFO"`                                          | Allowed values are `"INFO"`, `"DEBUG"`, `"WARN"`, `"TRACE"` |
| service.type      | `"ClusterIP"`                                     | Type of the service that is exposed                         |
| service.port      | `8080`                                            | Port number of the exposed service                          |

### Additional parameters

Additional parameters may be found in the [values.yaml](values.yaml) and dependencies.
See dependent charts for the description of available parameters.
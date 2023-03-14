# Utils Service - CZERTAINLY

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
helm show values oci://harbor.3key.company/czertainly-helm/utils-service > values.yaml
```
Now edit the `values.yaml` according to your desired stated, see [Configurable parameters](#configurable-parameters) for more information.

**Install**

For the basic installation, run:
```bash
helm install --namespace czertainly -f values.yaml czertainly-utils-service oci://harbor.3key.company/czertainly-helm/utils-service
```

**Save your configuration**

Always make sure you save the `values.yaml` and all `--set` and `--set-file` options you used. You will need to use the same options when you upgrade to new versions with Helm. In case you are changing the configuration, save the new configuration.

### Upgrade

> **Warning**
> Be sure that you always save your previous configuration!

For upgrading the installation, update your configuration and run:
```bash
helm upgrade --namespace czertainly -f values.yaml czertainly-utils-service oci://harbor.3key.company/czertainly-helm/utils-service
```

### Uninstall

You can use the `helm uninstall` command to uninstall the application:
```bash
helm uninstall --namespace czertainly czertainly-utils-service
```

## Configurable parameters

You can find current values in the [values.yaml](values.yaml).
You can also Specify each parameter using the `--set` or `--set-file` argument to `helm install`.

### Global parameters

Global values are used to define common parameters for the chart and all its sub-charts by exactly the same name.

| Parameter                                 | Default value | Description                                                        |
|-------------------------------------------|---------------|--------------------------------------------------------------------|
| global.image.registry                     | `""`          | Global docker registry name                                        |
| global.image.pullSecrets                  | `[]`          | Global array of secret names for image pull                        |
| global.volumes.ephemeral.type             | `""`          | Global ephemeral volume type to be used                            |
| global.volumes.ephemeral.sizeLimit        | `""`          | Global ephemeral volume size limit                                 |
| global.volumes.ephemeral.storageClassName | `""`          | Global ephemeral volume storage class name for `storage` type      |
| global.volumes.ephemeral.custom           | `{}`          | Global custom definition of the ephemeral volume for `custom` type |

### Local parameters

The following values may be configured:

| Parameter                                    | Default value                         | Description                                                 |
|----------------------------------------------|---------------------------------------|-------------------------------------------------------------|
| image.registry                               | `harbor.3key.company`                 | Docker registry name for the image                          |
| image.repository                             | `czertainly/czertainly-utils-service` | Docker image repository name                                |
| image.tag                                    | `develop-latest`                      | Docker image tag                                            |
| image.digest                                 | `""`                                  | Docker image digest, will override tag if specified         |
| image.pullPolicy                             | `IfNotPresent`                        | Image pull policy                                           |
| image.pullSecrets                            | `[]`                                  | Array of secret names for image pull                        |
| image.securityContext.runAsNonRoot           | `true`                                | Run the container as non-root user                          |
| image.securityContext.runAsUser              | `10001`                               | User ID for the container                                   |
| image.securityContext.readOnlyRootFilesystem | `true`                                | Run the container with read-only root filesystem            |
| podSecurityContext                           | `{}`                                  | Pod security context                                        |
| volumes.ephemeral.type                       | `memory`                              | Ephemeral volume type to be used                            |
| volumes.ephemeral.sizeLimit                  | `"1Mi"`                               | Ephemeral volume size limit                                 |
| volumes.ephemeral.storageClassName           | `""`                                  | Ephemeral volume storage class name for `storage` type      |
| volumes.ephemeral.custom                     | `{}`                                  | Custom definition of the ephemeral volume for `custom` type |
| logging.level                                | `"INFO"`                              | Allowed values are `"INFO"`, `"DEBUG"`, `"WARN"`, `"TRACE"` |
| service.type                                 | `"ClusterIP"`                         | Type of the service that is exposed                         |
| service.port                                 | `8080`                                | Port number of the exposed service                          |
| javaOpts                                     | `""`                                  | Customize Java system properties                            |

#### Probes parameters

For mode details about probes, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

| Parameter                                  | Default value | Description                                                                        |
|--------------------------------------------|---------------|------------------------------------------------------------------------------------|
| image.probes.liveness.enabled              | `true`        | Enable/disable liveness probe                                                      |
| image.probes.liveness.custom               | `{}`          | Custom liveness probe command. When defined, it will override the default command  |
| image.probes.liveness.initialDelaySeconds  | `60`          | Initial delay seconds for liveness probe                                           |
| image.probes.liveness.timeoutSeconds       | `5`           | Timeout seconds for liveness probe                                                 |
| image.probes.liveness.periodSeconds        | `10`          | Period seconds for liveness probe                                                  |
| image.probes.liveness.successThreshold     | `1`           | Success threshold for liveness probe                                               |
| image.probes.liveness.failureThreshold     | `3`           | Failure threshold for liveness probe                                               |
| image.probes.readiness.enabled             | `true`        | Enable/disable readiness probe                                                     |
| image.probes.readiness.custom              | `{}`          | Custom readiness probe command. When defined, it will override the default command |
| image.probes.readiness.initialDelaySeconds | `60`          | Initial delay seconds for readiness probe                                          |
| image.probes.readiness.timeoutSeconds      | `5`           | Timeout seconds for readiness probe                                                |
| image.probes.readiness.periodSeconds       | `10`          | Period seconds for readiness probe                                                 |
| image.probes.readiness.successThreshold    | `1`           | Success threshold for readiness probe                                              |
| image.probes.readiness.failureThreshold    | `3`           | Failure threshold for readiness probe                                              |
| image.probes.startup.enabled               | `false`       | Enable/disable startup probe                                                       |
| image.probes.startup.custom                | `{}`          | Custom startup probe command. When defined, it will override the default command   |
| image.probes.startup.initialDelaySeconds   | `60`          | Initial delay seconds for startup probe                                            |
| image.probes.startup.timeoutSeconds        | `5`           | Timeout seconds for startup probe                                                  |
| image.probes.startup.periodSeconds         | `10`          | Period seconds for startup probe                                                   |
| image.probes.startup.successThreshold      | `1`           | Success threshold for startup probe                                                |
| image.probes.startup.failureThreshold      | `10`          | Failure threshold for startup probe                                                |

### Additional parameters

Additional parameters may be found in the [values.yaml](values.yaml) and dependencies.
See dependent charts for the description of available parameters.
# Caching Valkey - CZERTAINLY

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/CZERTAINLY/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

This chart deploys a single-instance Valkey used as an ephemeral cache and session store for the CZERTAINLY platform. No persistence is configured, so a Deployment is used instead of a StatefulSet. For HA environments, use an external Valkey or Redis service via `global.valkey.external` configuration.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.8.0+

## Using this Chart

### Installation

**Create namespace**

We'll need to define a Kubernetes namespace where the resources created by the Chart should be installed:
```bash
kubectl create namespace czertainly
```

**Create `values.yaml`**

> **Note**
> You can also use `--set` options for the helm to apply configuration for the chart.

Copy the default `values.yaml` from the Helm chart and modify the values accordingly:
```bash
helm show values oci://harbor.3key.company/czertainly-helm/caching-valkey > values.yaml
```
Now edit the `values.yaml` according to your desired stated, see [Configurable parameters](#configurable-parameters) for more information.

**Install**

For the basic installation, run:
```bash
helm install --namespace czertainly -f values.yaml czertainly-caching-valkey oci://harbor.3key.company/czertainly-helm/caching-valkey
```

**Save your configuration**

Always make sure you save the `values.yaml` and all `--set` and `--set-file` options you used. You will need to use the same options when you upgrade to new versions with Helm. In case you are changing the configuration, save the new configuration.

### Upgrade

> **Warning**
> Be sure that you always save your previous configuration!

For upgrading the installation, update your configuration and run:
```bash
helm upgrade --namespace czertainly -f values.yaml czertainly-caching-valkey oci://harbor.3key.company/czertainly-helm/caching-valkey
```

### Uninstall

You can use the `helm uninstall` command to uninstall the application:
```bash
helm uninstall --namespace czertainly czertainly-caching-valkey
```

## Configurable parameters

You can find current values in the [values.yaml](values.yaml).
You can also Specify each parameter using the `--set` or `--set-file` argument to `helm install`.

### Global parameters

Global values are used to define common parameters for the chart and all its sub-charts by exactly the same name.

| Parameter                                 | Default value | Description                                                           |
|-------------------------------------------|---------------|-----------------------------------------------------------------------|
| global.image.registry                     | `""`          | Global docker registry name                                           |
| global.image.repository                   | `""`          | Global docker image repository name                                   |
| global.image.pullSecrets                  | `[]`          | Global array of secret names for image pull                           |
| global.valkey.password                    | `""`          | Password to access the Valkey (optional)                              |
| global.volumes.ephemeral.type             | `""`          | Global ephemeral volume type                                          |
| global.volumes.ephemeral.sizeLimit        | `""`          | Global ephemeral volume size limit                                    |
| global.volumes.ephemeral.storageClassName  | `""`          | Global ephemeral volume storage class name                            |
| global.volumes.ephemeral.custom           | `{}`          | Global custom ephemeral volume definition                             |
| global.httpProxy                          | `""`          | Proxy to be used to access external resources through http            |
| global.httpsProxy                         | `""`          | Proxy to be used to access external resources through https           |
| global.noProxy                            | `""`          | Defines list of external resources that should not use proxy settings |
| global.initContainers                     | `[]`          | Global init containers                                                |
| global.sidecarContainers                  | `[]`          | Global sidecar containers                                             |
| global.additionalVolumes                  | `[]`          | Global additional volumes                                             |
| global.additionalVolumeMounts             | `[]`          | Global additional volume mounts                                       |
| global.additionalPorts                    | `[]`          | Global additional ports                                               |
| global.additionalEnv.variables            | `[]`          | Global additional environment variables                               |
| global.additionalEnv.secrets              | `[]`          | Global additional environment secrets                                 |
| global.additionalEnv.configMaps           | `[]`          | Global additional environment config maps                             |

### Local parameters

The following values may be configured:

| Parameter                                    | Default value      | Description                                                                                                     |
|----------------------------------------------|--------------------|-----------------------------------------------------------------------------------------------------------------|
| replicaCount                                 | `1`                | Number of replicas for the deployment                                                                           |
| image.registry                               | `docker.io`        | Docker registry name for the image                                                                              |
| image.repository                             | `valkey`           | Docker image repository name                                                                                    |
| image.name                                   | `valkey`           | Docker image name                                                                                               |
| image.tag                                    | `8.1.1-alpine`     | Docker image tag                                                                                                |
| image.digest                                 | `""`               | Docker image digest, will override tag if specified                                                             |
| image.pullPolicy                             | `IfNotPresent`     | Image pull policy                                                                                               |
| image.pullSecrets                            | `[]`               | Array of secret names for image pull                                                                            |
| image.command                                | `[]`               | Override the default command                                                                                    |
| image.args                                   | `[]`               | Override the default args                                                                                       |
| image.securityContext.runAsNonRoot           | `true`             | Run the container as non-root user                                                                              |
| image.securityContext.runAsUser              | `999`              | User ID to run the container                                                                                    |
| image.securityContext.runAsGroup             | `999`              | Group ID to run the container                                                                                   |
| image.securityContext.readOnlyRootFilesystem | `true`             | Run the container with read-only root filesystem                                                                |
| image.resources                              | `{}`               | The resources for the container                                                                                 |
| valkey.password                              | `""`               | Optional password for Valkey authentication                                                                     |
| valkey.maxmemory                             | `"256mb"`          | Maximum memory Valkey can use                                                                                   |
| valkey.maxmemoryPolicy                       | `"allkeys-lru"`    | Eviction policy when maxmemory is reached                                                                       |
| service.type                                 | `"ClusterIP"`      | Type of the service that is exposed                                                                             |
| service.port                                 | `6379`             | Port number of the exposed service                                                                              |
| volumes.ephemeral.type                       | `memory`           | Ephemeral volume type to be used (`memory`, `storage`, `custom`)                                                |
| volumes.ephemeral.sizeLimit                  | `"1Mi"`            | Ephemeral volume size limit                                                                                     |
| volumes.ephemeral.storageClassName           | `""`               | Ephemeral volume storage class name for `storage` type                                                          |
| volumes.ephemeral.custom                     | `{}`               | Custom definition of the ephemeral volume for `custom` type                                                     |
| logging.level                                | `"info"`           | Logging level                                                                                                   |
| podLabels                                    | `{}`               | Labels to be added to the pod                                                                                   |
| podAnnotations                               | `{}`               | Annotations to be added to the pod                                                                              |
| podSecurityContext.fsGroup                   | `999`              | Pod filesystem group                                                                                            |
| serviceAccount.create                        | `true`             | Specifies whether a service account should be created                                                           |
| serviceAccount.annotations                   | `{}`               | Annotations to add to the service account                                                                       |
| serviceAccount.name                          | `""`               | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |

#### Customization parameters

| Parameter                | Default value | Description                        |
|--------------------------|---------------|------------------------------------|
| initContainers           | `[]`          | Init containers                    |
| sidecarContainers        | `[]`          | Sidecar containers                 |
| additionalVolumes        | `[]`          | Additional volumes                 |
| additionalVolumeMounts   | `[]`          | Additional volume mounts           |
| additionalPorts          | `[]`          | Additional ports                   |
| additionalEnv.variables  | `[]`          | Additional environment variables   |
| additionalEnv.secrets    | `[]`          | Additional environment secrets     |
| additionalEnv.configMaps | `[]`          | Additional environment config maps |

#### Probes parameters

For mode details about probes, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

| Parameter                                  | Default value | Description                                                                        |
|--------------------------------------------|---------------|------------------------------------------------------------------------------------|
| image.probes.liveness.enabled              | `true`        | Enable/disable liveness probe                                                      |
| image.probes.liveness.custom               | `{}`          | Custom liveness probe command. When defined, it will override the default command  |
| image.probes.liveness.initialDelaySeconds  | `5`           | Initial delay seconds for liveness probe                                           |
| image.probes.liveness.timeoutSeconds       | `5`           | Timeout seconds for liveness probe                                                 |
| image.probes.liveness.periodSeconds        | `10`          | Period seconds for liveness probe                                                  |
| image.probes.liveness.successThreshold     | `1`           | Success threshold for liveness probe                                               |
| image.probes.liveness.failureThreshold     | `3`           | Failure threshold for liveness probe                                               |
| image.probes.readiness.enabled             | `true`        | Enable/disable readiness probe                                                     |
| image.probes.readiness.custom              | `{}`          | Custom readiness probe command. When defined, it will override the default command |
| image.probes.readiness.initialDelaySeconds | `5`           | Initial delay seconds for readiness probe                                          |
| image.probes.readiness.timeoutSeconds      | `5`           | Timeout seconds for readiness probe                                                |
| image.probes.readiness.periodSeconds       | `10`          | Period seconds for readiness probe                                                 |
| image.probes.readiness.successThreshold    | `1`           | Success threshold for readiness probe                                              |
| image.probes.readiness.failureThreshold    | `3`           | Failure threshold for readiness probe                                              |
| image.probes.startup.enabled               | `true`        | Enable/disable startup probe                                                       |
| image.probes.startup.custom                | `{}`          | Custom startup probe command. When defined, it will override the default command   |
| image.probes.startup.initialDelaySeconds   | `5`           | Initial delay seconds for startup probe                                            |
| image.probes.startup.timeoutSeconds        | `5`           | Timeout seconds for startup probe                                                  |
| image.probes.startup.periodSeconds         | `10`          | Period seconds for startup probe                                                   |
| image.probes.startup.successThreshold      | `1`           | Success threshold for startup probe                                                |
| image.probes.startup.failureThreshold      | `10`          | Failure threshold for startup probe                                                |

### Additional parameters

Additional parameters may be found in the [values.yaml](values.yaml) and dependencies.
See dependent charts for the description of available parameters.

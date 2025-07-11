# PgBouncer - CZERTAINLY

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/CZERTAINLY/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.8.0+
- PostgreSQL 12+

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
helm show values oci://harbor.3key.company/czertainly-helm/pg-bouncer > values.yaml
```
Now edit the `values.yaml` according to your desired stated, see [Configurable parameters](#configurable-parameters) for more information.

**Install**

For the basic installation, run:
```bash
helm install --namespace czertainly -f values.yaml czertainly-pg-bouncer oci://harbor.3key.company/czertainly-helm/pg-bouncer
```

**Save your configuration**

Always make sure you save the `values.yaml` and all `--set` and `--set-file` options you used. You will need to use the same options when you upgrade to new versions with Helm. In case you are changing the configuration, save the new configuration.

### Upgrade

> **Warning**
> Be sure that you always save your previous configuration!

For upgrading the installation, update your configuration and run:
```bash
helm upgrade --namespace czertainly -f values.yaml czertainly-pg-bouncer oci://harbor.3key.company/czertainly-helm/pg-bouncer
```

### Uninstall

You can use the `helm uninstall` command to uninstall the application:
```bash
helm uninstall --namespace czertainly czertainly-pg-bouncer
```

## Configurable parameters

You can find current values in the [values.yaml](values.yaml).
You can also Specify each parameter using the `--set` or `--set-file` argument to `helm install`.

### Global parameters

Global values are used to define common parameters for the chart and all its sub-charts by exactly the same name.

| Parameter                       | Default value | Description                                                           |
|---------------------------------|---------------|-----------------------------------------------------------------------|
| global.replicaCount             | `1`           | Number of replicas for the application                                |
| global.image.registry           | `""`          | Global docker registry name                                           |
| global.image.repository         | `""`          | Global docker image repository name                                   |
| global.image.pullSecrets        | `[]`          | Global array of secret names for image pull                           |
| global.database.host            | `""`          | Host where is the database located                                    |
| global.database.port            | `""`          | Port on which is the database listening                               |
| global.database.name            | `""`          | Database name                                                         |
| global.database.username        | `""`          | Username to access the database                                       |
| global.database.password        | `""`          | Password to access the database                                       |
| global.httpProxy                | `""`          | Proxy to be used to access external resources through http            |
| global.httpsProxy               | `""`          | Proxy to be used to access external resources through https           |
| global.noProxy                  | `""`          | Defines list of external resources that should not use proxy settings |
| global.initContainers           | `[]`          | Global init containers                                                |
| global.sidecarContainers        | `[]`          | Global sidecar containers                                             |
| global.additionalVolumes        | `[]`          | Global additional volumes                                             |
| global.additionalVolumeMounts   | `[]`          | Global additional volume mounts                                       |
| global.additionalPorts          | `[]`          | Global additional ports                                               |
| global.additionalEnv.variables  | `[]`          | Global additional environment variables                               |
| global.additionalEnv.secrets    | `[]`          | Global additional environment secrets                                 |
| global.additionalEnv.configMaps | `[]`          | Global additional environment config maps                             |

### Local parameters

The following values may be configured:

| Parameter                                      | Default value            | Description                                                           |
|------------------------------------------------|--------------------------|-----------------------------------------------------------------------|
| image.registry                                 | `docker.io`              | Docker registry name for the image                                    |
| image.repository                               | `edoburu`                | Docker image repository name                                          |
| image.name                                     | `pgbouncer`              | Docker image name                                                     |
| image.tag                                      | `v1.24.0-p0`             | Docker image tag                                                      |
| image.digest                                   | `""`                     | Docker image digest, will override tag if specified                   |
| image.pullPolicy                               | `IfNotPresent`           | Image pull policy                                                     |
| image.pullSecrets                              | `[]`                     | Array of secret names for image pull                                  |
| image.command                                  | `[]`                     | Override the default command                                          |
| image.args                                     | `[]`                     | Override the default args                                             |
| image.securityContext.runAsNonRoot             | `true`                   | Run the container as non-root user                                    |
| image.securityContext.readOnlyRootFilesystem   | `true`                   | Run the container with read-only root filesystem                      |
| image.securityContext.allowPrivilegeEscalation | `false`                  | Allow privilege escalation for the container                          |
| image.securityContext.capabilities.drop        | `['all']`                | Drop all capabilities for the container                               |
| image.resources                                | `{}`                     | The resources for the container                                       |
| podLabels                                      | `{}`                     | Labels to be added to the pod                                         |
| podAnnotations                                 | `{}`                     | Annotations to be added to the pod                                    |
| podSecurityContext                             | `{}`                     | Pod security context                                                  |
| database.host                                  | `"host.docker.internal"` | Host where is the database located                                    |
| database.port                                  | `5432`                   | Port on which is the database listening                               |
| database.name                                  | `"czertainlydb"`         | Database name                                                         |
| database.username                              | `"czertainlyuser"`       | Username to access the database                                       |
| database.password                              | `"your-strong-password"` | Password to access the database                                       |
| httpProxy                                      | `""`                     | Proxy to be used to access external resources through http            |
| httpsProxy                                     | `""`                     | Proxy to be used to access external resources through https           |
| httpProxy                                      | `""`                     | Defines list of external resources that should not use proxy settings |
| service.type                                   | `"ClusterIP"`            | Type of the service that is exposed                                   |
| service.port                                   | `8080`                   | Port number of the exposed service                                    |

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
| image.probes.liveness.enabled              | `false`       | Enable/disable liveness probe                                                      |
| image.probes.liveness.custom               | `{}`          | Custom liveness probe command. When defined, it will override the default command  |
| image.probes.liveness.initialDelaySeconds  | `5`           | Initial delay seconds for liveness probe                                           |
| image.probes.liveness.timeoutSeconds       | `5`           | Timeout seconds for liveness probe                                                 |
| image.probes.liveness.periodSeconds        | `60`          | Period seconds for liveness probe                                                  |
| image.probes.liveness.successThreshold     | `1`           | Success threshold for liveness probe                                               |
| image.probes.liveness.failureThreshold     | `3`           | Failure threshold for liveness probe                                               |
| image.probes.readiness.enabled             | `true`        | Enable/disable readiness probe                                                     |
| image.probes.readiness.custom              | `{}`          | Custom readiness probe command. When defined, it will override the default command |
| image.probes.readiness.initialDelaySeconds | `5`           | Initial delay seconds for readiness probe                                          |
| image.probes.readiness.timeoutSeconds      | `5`           | Timeout seconds for readiness probe                                                |
| image.probes.readiness.periodSeconds       | `60`          | Period seconds for readiness probe                                                 |
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
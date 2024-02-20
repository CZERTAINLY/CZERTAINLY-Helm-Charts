# API Gateway - Kong - CZERTAINLY

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.8.0+

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
helm show values oci://harbor.3key.company/czertainly-helm/api-gateway-kong > values.yaml
```
Now edit the `values.yaml` according to your desired stated, see [Configurable parameters](#configurable-parameters) for more information.

**Install**

For the basic installation, run:
```bash
helm install --namespace czertainly -f values.yaml czertainly-api-gateway-kong oci://harbor.3key.company/czertainly-helm/api-gateway-kong
```

**Save your configuration**

Always make sure you save the `values.yaml` and all `--set` and `--set-file` options you used. You will need to use the same options when you upgrade to new versions with Helm. In case you are changing the configuration, save the new configuration.

### Upgrade

> **Warning**
> Be sure that you always save your previous configuration!

For upgrading the installation, update your configuration and run:
```bash
helm upgrade --namespace czertainly -f values.yaml czertainly-api-gateway-kong oci://harbor.3key.company/czertainly-helm/api-gateway-kong
```

### Uninstall

You can use the `helm uninstall` command to uninstall the application:
```bash
helm uninstall --namespace czertainly czertainly-api-gateway-kong
```

## Configurable parameters

You can find current values in the [values.yaml](values.yaml).
You can also Specify each parameter using the `--set` or `--set-file` argument to `helm install`.

### Global parameters

Global values are used to define common parameters for the chart and all its sub-charts by exactly the same name.

| Parameter                                 | Default value | Description                                                        |
|-------------------------------------------|---------------|--------------------------------------------------------------------|
| global.config.enabled                     | `false`       | Enables global configuration                                       |
| global.image.registry                     | `""`          | Global docker registry name                                        |
| global.image.repository                   | `""`          | Global docker image repository name                                |
| global.image.pullSecrets                  | `[]`          | Global array of secret names for image pull                        |
| global.volumes.ephemeral.type             | `""`          | Global ephemeral volume type to be used                            |
| global.volumes.ephemeral.sizeLimit        | `""`          | Global ephemeral volume size limit                                 |
| global.volumes.ephemeral.storageClassName | `""`          | Global ephemeral volume storage class name for `storage` type      |
| global.volumes.ephemeral.custom           | `{}`          | Global custom definition of the ephemeral volume for `custom` type |
| global.hostName                           | `""`          | Global hostname of the running instance                            |
| global.keycloak.enabled                   | `false`       | Enables internal Keycloak for authentication                       |
| global.keycloak.clientSecret              | `""`          | Keycloak OIDC client secret to be used internally                  |
| global.utils.enabled                      | `false`       | Enables external access to Utils Service                           |
| global.messaging.remoteAccess             | `false`       | Enable remote access to messaging service                          |
| global.initContainers                     | `[]`          | Global init containers                                             |
| global.sidecarContainers                  | `[]`          | Global sidecar containers                                          |
| global.additionalVolumes                  | `[]`          | Global additional volumes                                          |
| global.additionalVolumeMounts             | `[]`          | Global additional volume mounts                                    |
| global.additionalPorts                    | `[]`          | Global additional ports                                            |
| global.additionalEnv.variables            | `[]`          | Global additional environment variables                            |
| global.additionalEnv.secrets              | `[]`          | Global additional environment secrets                              |
| global.additionalEnv.configMaps           | `[]`          | Global additional environment config maps                          |

### Local parameters

The following values may be configured:

| Parameter                                    | Default value                                         | Description                                                                                |
|----------------------------------------------|-------------------------------------------------------|--------------------------------------------------------------------------------------------|
| image.registry                               | `docker.io`                                           | Docker registry name for the image                                                         |
| image.repository                             | `revomatico`                                          | Docker image repository name                                                               |
| image.name                                   | `docker-kong-oidc`                                    | Docker image name                                                                          |
| image.tag                                    | `3.4.0-2`                                             | Docker image tag                                                                           |
| image.digest                                 | `""`                                                  | Docker image digest, will override tag if specified                                        |
| image.pullPolicy                             | `IfNotPresent`                                        | Image pull policy                                                                          |
| image.pullSecrets                            | `[]`                                                  | Array of secret names for image pull                                                       |
| image.securityContext.runAsNonRoot           | `true`                                                | Run the container as non-root user                                                         |
| image.securityContext.runAsUser              | `100`                                                 | User ID for the container                                                                  |
| image.securityContext.readOnlyRootFilesystem | `true`                                                | Run the container with read-only root filesystem                                           |
| image.resources                              | `{}`                                                  | The resources for the container                                                            |
| podSecurityContext                           | `{}`                                                  | Pod security context                                                                       |
| volumes.ephemeral.type                       | `memory`                                              | Ephemeral volume type to be used                                                           |
| volumes.ephemeral.sizeLimit                  | `"1Mi"`                                               | Ephemeral volume size limit                                                                |
| volumes.ephemeral.storageClassName           | `""`                                                  | Ephemeral volume storage class name for `storage` type                                     |
| volumes.ephemeral.custom                     | `{}`                                                  | Custom definition of the ephemeral volume for `custom` type                                |
| logging.level                                | `"info"`                                              | Allowed values are `debug`, `info`, `notice`, `warn`, `error`, `crit`, `alert`, or `emerg` |
| service.type                                 | `"ClusterIP"`                                         | Type of the service that is exposed                                                        |
| service.admin.port                           | `8001`                                                | Port number of the exposed admin service                                                   |
| service.admin.nodePort                       | `""`                                                  | Node port to be exposed for admin service (only works with `service.type: NodePort`)       |
| service.consumer.port                        | `8000`                                                | Port number of the exposed consumer service                                                |
| service.consumer.nodePort                    | `""`                                                  | Node port to be exposed for consumer service (only works with `service.type: NodePort`)    |
| backend.core.service.name                    | `"core-service"`                                      | Name of the Core service                                                                   |
| backend.core.service.port                    | `8080`                                                | Port number of the Core service                                                            |
| backend.core.service.apiUrl                  | `"/api"`                                              | Base URL of the API requests                                                               |
| backend.fe.service.name                      | `"fe-administrator-service"`                          | Name of the front end service                                                              |
| backend.fe.service.port                      | `80`                                                  | Port number of the front end service                                                       |
| backend.fe.service.baseUrl                   | `"/administrator"`                                    | URL of the frontend application                                                            |
| backend.fe.service.apiUrl                    | `"/api"`                                              | URL of the API requests                                                                    |
| backend.fe.service.loginUrl                  | `"/login"`                                            | URL of the login page                                                                      |
| backend.fe.service.logoutUrl                 | `"/logout"`                                           | URL of the logout page                                                                     |
| auth.header.cert.downstream                  | `"ssl-client-cert"`                                   | Downstream header name containing certificate                                              |
| auth.header.cert.upstream                    | `"X-APP-CERTIFICATE"`                                 | Upstream header name to forward certificate                                                |
| oidc.enabled                                 | `false`                                               | Whether the OIDC plugin should be enabled for external authentication                      |
| oidc.client.id                               | `czertainly`                                          | OIDC client ID                                                                             |
| oidc.client.secret                           | `s0qKH5qItTWoxpBt7Zrj348Zha7woAbk`                    | OIDC client secret                                                                         |
| oidc.client.realm                            | `czertainly`                                          | Realm used in WWW-Authenticate response header                                             |
| oidc.client.discovery                        | `https://server.com/.well-known/openid-configuration` | OIDC discovery endpoint                                                                    |
| cors.enabled                                 | `false`                                               | Whether CORS plugin should be enabled                                                      |
| cors.origins                                 | `['*']`                                               | List of allowed domains for the Access-Control-Allow-Origin header                         |
| cors.exposedHeaders                          | `[X-Auth-Token]`                                      | List of values for the Access-Control-Expose-Headers header                                |
| trustedIps                                   | `""`                                                  | Defines trusted IP addresses blocks that are known to send correct `X-Forwarded-*` headers |
| hostAliases.resolveInternalKeycloak          | `false`                                               | Resolves internal Keycloak services as hostname for the OIDC client                        |

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

### Parameters for associated containers

**kubectl**

| Parameter                                            | Default value     | Description                                         |
|------------------------------------------------------|-------------------|-----------------------------------------------------|
| kubectl.image.registry                               | `docker.io`       | Docker registry name for the image                  |
| kubectl.image.repository                             | `bitnami`         | Docker image repository name                        |
| kubectl.image.name                                   | `kubectl`         | Docker image name                                   |
| kubectl.image.tag                                    | `1.27.3`          | Docker image tag                                    |
| kubectl.image.digest                                 | `""`              | Docker image digest, will override tag if specified |
| kubectl.image.pullPolicy                             | `IfNotPresent`    | Image pull policy                                   |
| kubectl.image.pullSecrets                            | `[]`              | Array of secret names for image pull                |
| kubectl.image.securityContext.runAsNonRoot           | `true`            | Run the container as non-root user                  |
| kubectl.image.securityContext.runAsUser              | `1001`            | User ID for the container                           |
| kubectl.image.securityContext.readOnlyRootFilesystem | `true`            | Run the container with read-only root filesystem    |

#### Probes parameters

For mode details about probes, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

| Parameter                                  | Default value | Description                                                                        |
|--------------------------------------------|---------------|------------------------------------------------------------------------------------|
| image.probes.liveness.enabled              | `false`       | Enable/disable liveness probe                                                      |
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
| image.probes.startup.initialDelaySeconds   | `15`          | Initial delay seconds for startup probe                                            |
| image.probes.startup.timeoutSeconds        | `5`           | Timeout seconds for startup probe                                                  |
| image.probes.startup.periodSeconds         | `10`          | Period seconds for startup probe                                                   |
| image.probes.startup.successThreshold      | `1`           | Success threshold for startup probe                                                |
| image.probes.startup.failureThreshold      | `45`          | Failure threshold for startup probe                                                |

### Additional parameters

Additional parameters may be found in the [values.yaml](values.yaml) and dependencies.
See dependent charts for the description of available parameters.
# Proxy - CZERTAINLY

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/CZERTAINLY/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

The Proxy chart deploys the Azure Service Bus / RabbitMQ proxy that bridges message brokers with backend connector services.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.8.0+
- Azure Service Bus namespace or RabbitMQ instance

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
helm show values oci://harbor.3key.company/czertainly-helm/proxy > values.yaml
```
Now edit the `values.yaml` according to your desired state, see [Configurable parameters](#configurable-parameters) for more information.

**Install**

For the basic installation, run:
```bash
helm install --namespace czertainly -f values.yaml czertainly-proxy oci://harbor.3key.company/czertainly-helm/proxy
```

**Save your configuration**

Always make sure you save the `values.yaml` and all `--set` and `--set-file` options you used. You will need to use the same options when you upgrade to new versions with Helm. In case you are changing the configuration, save the new configuration.

### Upgrade

> **Warning**
> Be sure that you always save your previous configuration!

For upgrading the installation, update your configuration and run:
```bash
helm upgrade --namespace czertainly -f values.yaml czertainly-proxy oci://harbor.3key.company/czertainly-helm/proxy
```

### Uninstall

You can use the `helm uninstall` command to uninstall the application:
```bash
helm uninstall --namespace czertainly czertainly-proxy
```

## Configurable parameters

You can find current values in the [values.yaml](values.yaml).
You can also specify each parameter using the `--set` or `--set-file` argument to `helm install`.

### Global parameters

Global values are used to define common parameters for the chart and all its sub-charts by exactly the same name.

| Parameter                                 | Default value | Description                                                        |
|-------------------------------------------|---------------|--------------------------------------------------------------------|
| global.image.registry                     | `""`          | Global docker registry name                                        |
| global.image.repository                   | `""`          | Global docker image repository name                                |
| global.image.pullSecrets                  | `[]`          | Global array of secret names for image pull                        |
| global.volumes.ephemeral.type             | `""`          | Global ephemeral volume type to be used                            |
| global.volumes.ephemeral.sizeLimit        | `""`          | Global ephemeral volume size limit                                 |
| global.volumes.ephemeral.storageClassName | `""`          | Global ephemeral volume storage class name for `storage` type      |
| global.volumes.ephemeral.custom           | `{}`          | Global custom definition of the ephemeral volume for `custom` type |
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

| Parameter                                    | Default value                     | Description                                                                                                             |
|----------------------------------------------|-----------------------------------|-------------------------------------------------------------------------------------------------------------------------|
| replicaCount                                 | `1`                               | Number of replicas for the deployment                                                                                   |
| image.registry                               | `ilmtestswcacr.azurecr.io` | Docker registry name for the image                                                                                      |
| image.repository                             | `""`                              | Docker image repository name                                                                                            |
| image.name                                   | `czertainly-proxy`                | Docker image name                                                                                                       |
| image.tag                                    | `v0.0.3`                          | Docker image tag                                                                                                        |
| image.digest                                 | `""`                              | Docker image digest, will override tag if specified                                                                     |
| image.pullPolicy                             | `IfNotPresent`                    | Image pull policy                                                                                                       |
| image.pullSecrets                            | `[]`                              | Array of secret names for image pull                                                                                    |
| image.command                                | `[]`                              | Override the default command                                                                                            |
| image.args                                   | `[]`                              | Override the default args                                                                                               |
| image.securityContext.runAsNonRoot           | `true`                            | Run the container as non-root user                                                                                      |
| image.securityContext.runAsUser              | `65534`                           | User ID to run the container                                                                                            |
| image.securityContext.runAsGroup             | `65534`                           | Group ID to run the container                                                                                           |
| image.securityContext.readOnlyRootFilesystem | `true`                            | Run the container with read-only root filesystem                                                                        |
| image.resources                              | `{}`                              | The resources for the container                                                                                         |
| podLabels                                    | `{}`                              | Additional labels for the pod                                                                                           |
| podAnnotations                               | `{}`                              | Additional annotations for the pod                                                                                      |
| podSecurityContext                           | `{}`                              | Pod security context                                                                                                    |
| nodeSelector                                 | `{}`                              | Node selector for the pod                                                                                               |
| tolerations                                  | `[]`                              | Tolerations for the pod                                                                                                 |
| affinity                                     | `{}`                              | Affinity for the pod                                                                                                    |
| volumes.ephemeral.type                       | `memory`                          | Ephemeral volume type to be used                                                                                        |
| volumes.ephemeral.sizeLimit                  | `"10Mi"`                          | Ephemeral volume size limit                                                                                             |
| volumes.ephemeral.storageClassName           | `""`                              | Ephemeral volume storage class name for `storage` type                                                                  |
| volumes.ephemeral.custom                     | `{}`                              | Custom definition of the ephemeral volume for `custom` type                                                             |
| service.type                                 | `"ClusterIP"`                     | Type of the service that is exposed                                                                                     |
| service.port                                 | `8080`                            | Port number of the exposed service                                                                                      |
| serviceAccount.create                        | `true`                            | Specifies whether a service account should be created                                                                   |
| serviceAccount.annotations                   | `{}`                              | Annotations to add to the service account                                                                               |
| serviceAccount.name                          | `""`                              | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |

#### Application parameters

| Parameter               | Default value    | Description                              |
|-------------------------|------------------|------------------------------------------|
| application.name        | `azure-sb-proxy` | Application name                         |
| application.environment | `production`     | Application environment                  |
| application.maxWorkers  | `10`             | Maximum number of concurrent workers     |

#### Token-based configuration

Token-based configuration allows you to configure the proxy using a single JWT token instead of individual parameters. When `token` is set, it takes precedence over all other configuration values.

| Parameter       | Default value | Description                                                        |
|-----------------|---------------|--------------------------------------------------------------------|
| token           | `""`          | JWT configuration token (takes precedence over all other config)   |
| tokenSigningKey | `""`          | HMAC signing key for token verification (HS256/HS384/HS512)        |

#### AMQP parameters

| Parameter                  | Default value       | Description                                                      |
|----------------------------|---------------------|------------------------------------------------------------------|
| amqp.brokerType            | `azureservicebus`   | Broker type: `azureservicebus` or `rabbitmq`                     |
| amqp.url                   | `""`                | Connection URL (wss://, amqps://, amqp://)                       |
| amqp.host                  | `""`                | Legacy: Broker hostname (used if url is empty)                   |
| amqp.port                  | `5671`              | Legacy: Broker port                                              |
| amqp.useTls                | `true`              | Legacy: Enable TLS                                               |
| amqp.authMethod            | `sasl-plain`        | Auth method: `sasl-plain` or `cbs`                               |
| amqp.username              | `""`                | SAS key name or username                                         |
| amqp.password              | `""`                | SAS key or password                                              |
| amqp.tokenExpiry           | `1h`                | CBS token expiry duration (minimum: 2m)                          |
| amqp.entraId.tenantId      | `""`                | Azure AD tenant ID for CBS authentication                        |
| amqp.entraId.clientId      | `""`                | Azure AD client ID for CBS authentication                        |
| amqp.entraId.clientSecret  | `""`                | Azure AD client secret for CBS authentication                    |
| amqp.topicName             | `""`                | Request topic name                                               |
| amqp.subscription          | `""`                | Subscription name                                                |
| amqp.responseTopic         | `""`                | Response topic name                                              |
| amqp.prefetchCount         | `10`                | AMQP prefetch count                                              |
| amqp.messageLockTime       | `300s`              | Message lock duration                                            |
| amqp.reconnect.initialDelay| `2s`                | Initial delay for reconnection                                   |
| amqp.reconnect.maxDelay    | `1m`                | Maximum delay for reconnection                                   |
| amqp.reconnect.factor      | `2.0`               | Backoff factor for reconnection                                  |

#### HTTP client parameters

| Parameter                      | Default value | Description                          |
|--------------------------------|---------------|--------------------------------------|
| httpClient.maxIdleConns        | `100`         | Maximum idle connections             |
| httpClient.maxIdleConnsPerHost | `10`          | Maximum idle connections per host    |
| httpClient.maxConnsPerHost     | `50`          | Maximum connections per host         |
| httpClient.idleConnTimeout     | `90s`         | Idle connection timeout              |
| httpClient.dialTimeout         | `10s`         | Dial timeout                         |
| httpClient.tlsHandshakeTimeout | `10s`         | TLS handshake timeout                |
| httpClient.keepAlive           | `30s`         | Keep-alive duration                  |
| httpClient.defaultTimeout      | `30s`         | Default request timeout              |

#### HTTP server parameters

| Parameter            | Default value | Description                  |
|----------------------|---------------|------------------------------|
| http.port            | `8080`        | HTTP server port             |
| http.readTimeout     | `10s`         | Read timeout                 |
| http.writeTimeout    | `10s`         | Write timeout                |
| http.shutdownTimeout | `30s`         | Graceful shutdown timeout    |

#### Logging and metrics parameters

| Parameter       | Default value | Description                                      |
|-----------------|---------------|--------------------------------------------------|
| logging.level   | `info`        | Log level: `debug`, `info`, `warn`, `error`      |
| logging.format  | `json`        | Log format: `json`, `console`, `text`            |
| metrics.enabled | `true`        | Enable Prometheus metrics                        |
| metrics.path    | `/metrics`    | Metrics endpoint path                            |

#### Autoscaling parameters

| Parameter                              | Default value | Description                        |
|----------------------------------------|---------------|------------------------------------|
| autoscaling.enabled                    | `false`       | Enable Horizontal Pod Autoscaler   |
| autoscaling.minReplicas                | `1`           | Minimum number of replicas         |
| autoscaling.maxReplicas                | `10`          | Maximum number of replicas         |
| autoscaling.targetCPUUtilizationPercentage | `80`      | Target CPU utilization percentage  |

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

For more details about probes, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

| Parameter                                  | Default value | Description                                                                        |
|--------------------------------------------|---------------|------------------------------------------------------------------------------------|
| image.probes.liveness.enabled              | `true`        | Enable/disable liveness probe                                                      |
| image.probes.liveness.custom               | `{}`          | Custom liveness probe command. When defined, it will override the default command  |
| image.probes.liveness.initialDelaySeconds  | `10`          | Initial delay seconds for liveness probe                                           |
| image.probes.liveness.timeoutSeconds       | `5`           | Timeout seconds for liveness probe                                                 |
| image.probes.liveness.periodSeconds        | `30`          | Period seconds for liveness probe                                                  |
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
| image.probes.startup.failureThreshold      | `30`          | Failure threshold for startup probe                                                |

### Additional parameters

Additional parameters may be found in the [values.yaml](values.yaml) and dependencies.
See dependent charts for the description of available parameters.

## Configuration Examples

### Azure Service Bus with Entra ID (Recommended)

```yaml
amqp:
  brokerType: "azureservicebus"
  url: "wss://your-namespace.servicebus.windows.net"
  authMethod: "cbs"
  entraId:
    tenantId: "your-tenant-id"
    clientId: "your-client-id"
    clientSecret: "your-client-secret"
  topicName: "requests"
  subscription: "proxy-sub"
  responseTopic: "responses"
```

### Azure Service Bus with SAS

```yaml
amqp:
  brokerType: "azureservicebus"
  url: "wss://your-namespace.servicebus.windows.net"
  authMethod: "sasl-plain"
  username: "RootManageSharedAccessKey"
  password: "your-sas-key"
  topicName: "requests"
  subscription: "proxy-sub"
  responseTopic: "responses"
```

### RabbitMQ

```yaml
amqp:
  brokerType: "rabbitmq"
  host: "rabbitmq.example.com"
  port: 5672
  useTls: false
  authMethod: "sasl-plain"
  username: "guest"
  password: "guest"
  topicName: "requests"
  subscription: "proxy-sub"
  responseTopic: "responses"
```

### Token-based Configuration

```yaml
token: "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJ2IjoxLCJjb25maWciOnsuLi59fQ."
```

For signed tokens:
```yaml
token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2IjoxLCJjb25maWciOnsuLi59fQ.signature"
tokenSigningKey: "your-hmac-secret-key"
```

## Health Checks

The proxy exposes the following health endpoints:

- **Liveness**: `GET /health` - Returns 200 when the process is running
- **Readiness**: `GET /ready` - Returns 200 when AMQP connection is active
- **Metrics**: `GET /metrics` - Prometheus metrics

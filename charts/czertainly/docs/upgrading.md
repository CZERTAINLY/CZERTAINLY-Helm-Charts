# Upgrading

:::warning[Before upgrading]
Before upgrading, make sure you have backed up your configuration, trusted certificates and data to be able to restore the platform in case of any issues.

Never downgrade the platform version, as it may cause data loss or other issues. Be sure that you are upgrading to higher version of the Helm chart.
:::

:::info[Upgrade vs Install]
Platform can be installed from scratch anytime when you have a backup of your database and configuration. New installation through the Helm chart will deploy new environment connecting to the same database. You can install multiple instances of the platform in different clusters and infrastructures with the same database.
:::

The following contains important information and instructions about upgrading Helm charts.

Upgrading Helm chart is done by running the `helm upgrade` command. The command upgrades the platform to the specified version. The command can be used to upgrade the platform to the same version with changed parameters.

## To 2.13.0

### Additional connector sub-charts

The following sub-charts were added to support additional connectors as optional components:
- CT Logs Discovery Provider

When you enable new connector during upgrade, you need to register the connector manually in the platform:
```yaml
ctLogsDiscoveryProvider:
  enabled: false
```

## To 2.11.0-1

### Additional connector sub-charts

The following sub-charts were added to support additional connectors as optional components:
- HashiCorp Vault Connector

When you enable new connector during upgrade, you need to register the connector manually in the platform:
```yaml
hashicorpVaultConnector:
  enabled: false
```

See the [CZERTAINLY Helm chart 2.11.0-1 release notes](https://github.com/3KeyCompany/CZERTAINLY-Helm-Charts/releases/tag/2.11.0-1) for more information.

## To 2.11.0

### New PyADCS connector

To resolve compatibility issues and improve performance of the ADCS certificate related operations and authentication, the new ADCS connector was introduced based on Python technology.
MS ADCS connector is considered from this version as deprecated and will be removed in the future.

When you enable PyADCS connector during upgrade, you need to register the connector manually in the platform:
```yaml
pyAdcsConnector:
  enabled: true
```

See the [CZERTAINLY Helm chart 2.11.0 release notes](https://github.com/3KeyCompany/CZERTAINLY-Helm-Charts/releases/tag/2.11.0) for more information.

## To 2.9.0

### Persistent volume provisioner

This version introduced requirement for the persistent volume provisioner support in the underlying infrastructure. The `StorageClass` is required to be available in the cluster. The volumes are dynamically provisioned by default, but it can be changed by setting existing persistent volume claim or disabling persistence (which will use `emptyDir` volume).

The list of components that need persistence can be found in the [Overview - Persistence](./overview.md#persistence) section.

:::warning[Persistent volume claim]
The provisioner of the persistent volume must be properly configured to upgrade the platform, in case the dynamic storage should be created. In case the dynamic provisioning is not enabled, the persistent volume claim must be created manually before upgrading the platform. Form more information see [Dynamic Volume Provisioning](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/).
:::

### Container image configuration and repository

To support multiple container registries, including better support for privately managed registries, where there are different naming conventions and images are organized in projects, we have split image `repository` property to `repository` and `name`.

This allows to control the repository name using the global configuration, providing better support for private repositories with different organization of images and repositories. For example the following values:

```yaml
global:
  image:
    registry: myregistry.com
    repository: czertainly/project

image:
  # default registry name
  registry: docker.io
  repository: 3keycompany
  name: czertainly-core
  tag: 2.9.0
```

will result in the following image name: `myregistry.com/czertainly/project/czertainly-core:2.9.0`.

### Customization of the deployment

The deployment of the platform can be customized using the following parameters:
```yaml
initContainers: []
sidecarContainers: []
additionalVolumes: []
additionalVolumeMounts: []
additionalPorts: []
additionalEnv:
  variables: []
  configMaps: []
  secrets: []
```

When the parameters are set globally, they are applied to all charts and sub-charts. When the parameters are set for specific chart or sub-chart, they are applied only to the sub-chart. If they global and local parameters are defined, they are merged together.

## To 2.8.0

Using `NodePort` to access the platform should be configured on API Gateway level, not for the Core service (as a service in `czertainly` chart). The `nodePort` parameter is included for both `admin` and `consumer` service in `api-gateway-kong` sub-chart. The proper way to configure `NodePort` is:

```yaml
ingress:
  # disable ingress as we are going to use direct access to the platform
  enabled: false

apiGateway:
  service:
    # use NodePort to access the platform
    type: "NodePort"
    consumer:
      port: 8000
      nodePort: 30080
    admin:
      port: 8001
      nodePort: 30081
```

See the [CZERTAINLY Helm chart 2.8.0 release notes](https://github.com/3KeyCompany/CZERTAINLY-Helm-Charts/releases/tag/2.8.0) for more information.

## To 2.7.1

### Enabling Utils Service

Enabling parameter of Utils Service was moved from the `utilsService.enabled` to global parameters:
```yaml
global:
  utils:
    enabled: false
```

See the [CZERTAINLY Helm chart 2.7.1 release notes](https://github.com/3KeyCompany/CZERTAINLY-Helm-Charts/releases/tag/2.7.1) for more information.

## To 2.7.0

### Cleanup of the global parameters

The global parameters were cleaned up and reorganized.

The following default parameters were removed. They must be explicitly set now in the values, if you want to use them. Check your current configuration and update it accordingly:
```yaml
global:
  database:
    type: ""
    host: ""
    port: ""
    name: ""
    username: ""
    password: ""
  trusted:
    certificates: ""
```

Hostname was introduced as a global parameter that can be shared across the deployment. The main reason is optional implementation of the internal Keycloak service that requires to know the hostname of the platform to properly set URLs:
```yaml
global:
  hostName: ""
```

Administrator registration information is introduced as global parameters. This allows to share for example the same data with internal Keycloak, if enabled. If you want to keep the client certificate-based authentication for administrator, configure certificate in the `registerAdmin.admin.certificate` parameter:
```yaml
global:
  admin:
    username: ""
    password: ""
    name: ""
    surname: ""
    email: ""
```

Be aware that you can always enable auto-provisioning of the users with JSON ID using the following parameter:
```yaml
authService:
  createUnknownUsers: "true"
  createUnknownRoles: "true"
```

### Hardening of the deployment

The deployment was hardened to be more secure and stable. The following changes were made for every container:
- running as non-root user
- running with read-only root filesystem
- specified default `securityContext`
- added configuration and default values for `livenessProbe`, `readinessProbe` and `startupProbe`
- added configuration for resource limits and requests

### Optional services

New optional services were added to the umbrella chart:
- Keycloak internal service
- Utils service

Keycloak internal service is disabled by default and can be enabled by setting the following values:
```yaml
global:
  keycloak:
    enabled: true
    # client secret must be set if keycloak is enabled
    clientSecret: ""
```

Utils service is disabled by default and can be enabled by setting the following values:

```yaml
utilsService:
  enabled: false
```

See the [CZERTAINLY Helm chart 2.7.0 release notes](https://github.com/3KeyCompany/CZERTAINLY-Helm-Charts/releases/tag/2.7.0) for more information.

## To 2.6.0

### ACME endpoint and trusted IPs

The API gateway sub-chart was updated to support ACME endpoint and trusted IPs.
Trusted IP addresses defines blocks that are known to send correct `X-Forwarded-*` headers which is important to generate correct URLs for the clients communicating with the platform behind gateway and proxy.

Trusted IP addresses can be configured in the API gateway dependency for the umbrella:
```yaml
apiGateway:
  trustedIps: ""
```

### Additional connector sub-charts

The Software Cryptography Provider connector was added as sub-chart to the umbrella chart.

When you enable new connector during upgrade, you need to register the connector manually in the platform:
```yaml
softwareCryptographyProvider:
  enabled: false
```

See the [CZERTAINLY Helm chart 2.6.0 release notes](https://github.com/3KeyCompany/CZERTAINLY-Helm-Charts/releases/tag/2.6.0) for more information.

## To 2.5.2

### Container image configuration

Configuration of container registry has changed. The new configuration is more flexible and allows to use multiple container registries, including configuration of registry globally.

Every image that is supported in the umbrella chart or sub-charts now has the following structure:
```yaml
image:
  # default registry name
  registry: docker.io
  # default repository name
  repository: 3keycompany/czertainly-core
  # default image tag
  tag: "2.5.2"
  # the digest to be used instead of the tag, will override tag if specified
  digest: ""
  # default image pull policy
  pullPolicy: IfNotPresent
  # array of image pull secrets
  pullSecrets: []
```

Container registry and image pull secrets can be also configured globally for the umbrella chart and all of its sub-charts using global parameters, for example:
```yaml
global:
  image:
    # registry name
    registry: "harbor.czertainly.online"
    # array of secret names
    pullSecrets:
      - harbor-registry-credentials
      - dockerhub-registry-credentials
```

### Additional connector sub-charts

The following sub-charts were added to support additional connectors as optional components:
- Cryptosense Discovery Provider
- Network Discovery Provider
- Keystore Entity Provider

When you enable new connector during upgrade, you need to register the connector manually in the platform:
```yaml
cryptosenseDiscoveryProvider:
  enabled: false

networkDiscoveryProvider:
  enabled: false

keystoreEntityProvider:
  enabled: false
```

See the [CZERTAINLY Helm chart 2.5.2 release notes](https://github.com/3KeyCompany/CZERTAINLY-Helm-Charts/releases/tag/2.5.2) for more information.

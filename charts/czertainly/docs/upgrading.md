# Upgrading

:::caution Before upgrading
Before upgrading, make sure you have backed up your configuration, trusted certificates and data to be able to restore the platform in case of any issues.

Never downgrade the platform version, as it may cause data loss or other issues. Be sure that you are upgrading to higher version of the Helm chart.
:::

:::info Upgrade vs Install
Platform can be installed from scratch anytime when you have a backup of your database and configuration. New installation through the Helm chart will deploy new environment connecting to the same database. You can install multiple instances of the platform in different clusters and infrastructures with the same database.
:::

The following contains important information and instructions about upgrading Helm charts.

Upgrading Helm chart is done by running the `helm upgrade` command. The command upgrades the platform to the specified version. The command can be used to upgrade the platform to the same version with changed parameters.

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

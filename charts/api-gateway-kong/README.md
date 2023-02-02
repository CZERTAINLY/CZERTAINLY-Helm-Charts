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

| Parameter                | Default value                | Description                                 |
|--------------------------|------------------------------|---------------------------------------------|
| global.image.registry    | `""`                         | Global docker registry name                 |
| global.image.pullSecrets | `[]`                         | Global array of secret names for image pull |

### Local parameters

The following values may be configured:

| Parameter                    | Default value                                         | Description                                                                                |
|------------------------------|-------------------------------------------------------|--------------------------------------------------------------------------------------------|
| image.registry               | `docker.io`                                           | Docker registry name for the image                                                         |
| image.repository             | `revomatico/docker-kong-oidc`                         | Docker image repository name                                                               |
| image.tag                    | `3.0.0-6`                                             | Docker image tag                                                                           |
| image.digest                 | `""`                                                  | Docker image digest, will override tag if specified                                        |
| image.pullPolicy             | `IfNotPresent`                                        | Image pull policy                                                                          |
| image.pullSecrets            | `[]`                                                  | Array of secret names for image pull                                                       |
| logging.level                | `"info"`                                              | Allowed values are `debug`, `info`, `notice`, `warn`, `error`, `crit`, `alert`, or `emerg` |
| service.type                 | `"ClusterIP"`                                         | Type of the service that is exposed                                                        |
| service.admin.port           | `8001`                                                | Port number of the exposed admin service                                                   |
| service.consumer.port        | `8000`                                                | Port number of the exposed consumer service                                                |
| backend.core.service.name    | `"core-service"`                                      | Name of the Core service                                                                   |
| backend.core.service.port    | `8080`                                                | Port number of the Core service                                                            |
| backend.core.service.apiUrl  | `"/api"`                                              | Base URL of the API requests                                                               |
| backend.fe.service.name      | `"fe-administrator-service"`                          | Name of the front end service                                                              |
| backend.fe.service.port      | `80`                                                  | Port number of the front end service                                                       |
| backend.fe.service.baseUrl   | `"/administrator"`                                    | URL of the frontend application                                                            |
| backend.fe.service.apiUrl    | `"/api"`                                              | URL of the API requests                                                                    |
| backend.fe.service.loginUrl  | `"/login"`                                            | URL of the login page                                                                      |
| backend.fe.service.logoutUrl | `"/logout"`                                           | URL of the logout page                                                                     |
| auth.header.cert.downstream  | `"ssl-client-cert"`                                   | Downstream header name containing certificate                                              |
| auth.header.cert.upstream    | `"X-APP-CERTIFICATE"`                                 | Upstream header name to forward certificate                                                |
| oidc.enabled                 | `false`                                               | Whether the OIDC plugin should be enabled for external authentication                      |
| oidc.client.id               | `czertainly`                                          | OIDC client ID                                                                             |
| oidc.client.secret           | `s0qKH5qItTWoxpBt7Zrj348Zha7woAbk`                    | OIDC client secret                                                                         |
| oidc.client.realm            | `czertainly`                                          | Realm used in WWW-Authenticate response header                                             |
| oidc.client.discovery        | `https://server.com/.well-known/openid-configuration` | OIDC discovery endpoint                                                                    |
| cors.enabled                 | `false`                                               | Whether CORS plugin should be enabled                                                      |
| cors.origins                 | `['*']`                                               | List of allowed domains for the Access-Control-Allow-Origin header                         |
| cors.exposedHeaders          | `[X-Auth-Token]`                                      | List of values for the Access-Control-Expose-Headers header                                |

### Additional parameters

Additional parameters may be found in the [values.yaml](values.yaml) and dependencies.
See dependent charts for the description of available parameters.
# CZERTAINLY-Helm-Charts

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.8.0+
- PostgreSQL 11+

In case you want to enable Ingress you need to have installed Ingress Controller, for example:
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml
```

If you are using internal CA for Ingress and Administrator certificate, you also need to have installed [cert-manager](https://cert-manager.io/docs/).

> cert-manager is only required to use certificates issued by internally generated CA:
> - `ingress.certificate.source=internal` for internally generated Ingress certificate
> - `ingress.certificate.source=letsEncrypt` for Ingress Let’s Encrypt issued certificate
> - `registerAdmin.source=generated` for internally generated certificate for first administrator

## Using this Chart

### Installation

**Create namespace**

We’ll need to define a Kubernetes namespace where the resources created by the Chart should be installed:
```bash
kubectl create namespace czertainly
```

**Create `czertainly-values.yaml`**

Copy the default `values.yaml` from the CZERTAINLY Helm chart and modify the values accordingly:
```bash
helm show values oci://harbor.3key.company/czertainly-helm/czertainly > czertainly-values.yaml
```
Now edit the `czertainly-values.yaml` according to your desired stated, see [Configurable parameters](#configurable-parameters) for more information.

**Prepare list of trusted CA certificates**

Create new file called `trusted-certificates.pem` and add to the file PEM certificates of all certification authorities that should be trusted by the platform. No worries, you can always change the list of trusted certificates in the future. See the sample [trusted-certificates](../../samples/trusted-certificates.pem) file.

The list of trusted certificates is need for the installation of the CZERTAINLY using Helm chart.

> **Note**
> Trusted certificates can be defined globally for the CZERTAINLY chart and all of its sub-charts, or it can be applied only for specific sub-chart, see [global parameters](#global-parameters). For global, set `global.trusted.certificates`, otherwise set `trusted.certificates`.

**Install CZERTAINLY**

There are couple of options to install CZERTAINLY based on you TLS configuration and administrator certificate handling. See the [Configurable parameters](#configurable-parameters) for more information.

For the basic installation, run:
```bash
helm install --namespace czertainly -f czertainly-values.yaml --set-file global.trusted.certificates=trusted-certificates.pem czertainly-tlm oci://harbor.3key.company/czertainly-helm/czertainly
```

**Save your configuration**

Always make sure you save the `czertainly-values.yaml` and all `--set` and `--set-file` options you used. You will need to use the same options when you upgrade CZERTAINLY to new versions with Helm. In case you are changing the configuration, save the new configuration.

### Upgrade

> **Warning**
> Be sure that you always save your previous configuration!

For upgrading the CZERTAINLY installation, update your configuration and run:
```bash
helm upgrade --namespace czertainly -f czertainly-values.yaml --set-file global.trusted.certificates=trusted-certificates.pem czertainly-tlm oci://harbor.3key.company/czertainly-helm/czertainly
```

### Uninstall

You can use the `helm uninstall` command to uninstall the CZERTAINLY:
```bash
helm uninstall --namespace czertainly czertainly-tlm
```

## Configurable parameters

You can find current values in the [values.yaml](values.yaml).
You can also Specify each parameter using the `--set` or `--set-file` argument to `helm install`.

> **Note**
> TBD

### Global parameters

Global values are used to define common parameters for the chart and all its sub-charts by exactly the same name.

| Parameter                                 | Default value | Description                                                           |
|-------------------------------------------|---------------|-----------------------------------------------------------------------|
| global.image.registry                     | `""`          | Global docker registry name                                           |
| global.image.pullSecrets                  | `[]`          | Global array of secret names for image pull                           |
| global.volumes.ephemeral.type             | `""`          | Global ephemeral volume type to be used                               |
| global.volumes.ephemeral.sizeLimit        | `""`          | Global ephemeral volume size limit                                    |
| global.volumes.ephemeral.storageClassName | `""`          | Global ephemeral volume storage class name for `storage` type         |
| global.volumes.ephemeral.custom           | `{}`          | Global custom definition of the ephemeral volume for `custom` type    |
| global.database.type                      | `""`          | Type of the database, currently only `postgresql` is supported        |
| global.database.host                      | `""`          | Host where is the database located                                    |
| global.database.port                      | `""`          | Port on which is the database listening                               |
| global.database.name                      | `""`          | Database name                                                         |
| global.database.username                  | `""`          | Username to access the database                                       |
| global.database.password                  | `""`          | Password to access the database                                       |
| global.trusted.certificates               | `""`          | List of additional CA certificates that should be trusted             |
| global.httpProxy                          | `""`          | Proxy to be used to access external resources through http            |
| global.httpsProxy                         | `""`          | Proxy to be used to access external resources through https           |
| global.noProxy                            | `""`          | Defines list of external resources that should not use proxy settings |
| global.hostName                           | `""`          | Global hostname of the running instance                               |
| global.keycloak.enabled                   | `false`       | Enables internal Keycloak for authentication                          |
| global.keycloak.clientSecret              | `""`          | Keycloak OIDC client secret to be used internally                     |
| global.admin.username                     | `""`          | Initial administrator username                                        |
| global.admin.password                     | `""`          | Initial administrator password                                        |
| global.admin.name                         | `""`          | Initial administrator first name                                      |
| global.admin.surname                      | `""`          | Initial administrator last name                                       |
| global.admin.email                        | `""`          | Initial administrator email                                           |

### Local parameters

The following values may be configured for the CZERTAINLY core service:

| Parameter                                    | Default value                                                                                                                                                                                                                                                                                                                                | Description                                                                                                                                                                                                                              |
|----------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| database.type                                | `"postgresql"`                                                                                                                                                                                                                                                                                                                               | Type of the database, currently only `postgresql` is supported                                                                                                                                                                           |
| database.host                                | `"host.docker.internal"`                                                                                                                                                                                                                                                                                                                     | Host where is the database located                                                                                                                                                                                                       |
| database.port                                | `5432`                                                                                                                                                                                                                                                                                                                                       | Port on which is the database listening                                                                                                                                                                                                  |
| database.name                                | `"czertainlydb"`                                                                                                                                                                                                                                                                                                                             | Database name                                                                                                                                                                                                                            |
| database.username                            | `"czertainlyuser"`                                                                                                                                                                                                                                                                                                                           | Username to access the database                                                                                                                                                                                                          |
| database.password                            | `"your-strong-password"`                                                                                                                                                                                                                                                                                                                     | Password to access the database                                                                                                                                                                                                          |
| trusted.certificates                         | `"CZERTAINLY Dummy Root CA"`                                                                                                                                                                                                                                                                                                                 | List of additional CA certificates that should be trusted                                                                                                                                                                                |
| image.registry                               | `docker.io`                                                                                                                                                                                                                                                                                                                                  | Docker registry name for the image                                                                                                                                                                                                       |
| image.repository                             | `3keycompany/czertainly-core`                                                                                                                                                                                                                                                                                                                | Docker image repository name                                                                                                                                                                                                             |
| image.tag                                    | `2.6.0`                                                                                                                                                                                                                                                                                                                                      | Docker image tag                                                                                                                                                                                                                         |
| image.digest                                 | `""`                                                                                                                                                                                                                                                                                                                                         | Docker image digest, will override tag if specified                                                                                                                                                                                      |
| image.pullPolicy                             | `IfNotPresent`                                                                                                                                                                                                                                                                                                                               | Image pull policy                                                                                                                                                                                                                        |
| image.pullSecrets                            | `[]`                                                                                                                                                                                                                                                                                                                                         | Array of secret names for image pull                                                                                                                                                                                                     |
| image.securityContext.runAsNonRoot           | `true`                                                                                                                                                                                                                                                                                                                                       | Run the container as non-root user                                                                                                                                                                                                       |
| image.securityContext.runAsUser              | `10001`                                                                                                                                                                                                                                                                                                                                      | User ID for the container                                                                                                                                                                                                                |
| image.securityContext.readOnlyRootFilesystem | `true`                                                                                                                                                                                                                                                                                                                                       | Run the container with read-only root filesystem                                                                                                                                                                                         |
| image.resources.requests                     | `cpu: 200m`<br>`memory: 2000M`                                                                                                                                                                                                                                                                                                               | The requested resources for the container                                                                                                                                                                                                |
| image.resources.limits                       | `{}`                                                                                                                                                                                                                                                                                                                                         | The resources limits for the container                                                                                                                                                                                                   |
| podSecurityContext                           | `{}`                                                                                                                                                                                                                                                                                                                                         | Pod security context                                                                                                                                                                                                                     |
| volumes.ephemeral.type                       | `memory`                                                                                                                                                                                                                                                                                                                                     | Ephemeral volume type to be used                                                                                                                                                                                                         |
| volumes.ephemeral.sizeLimit                  | `"1Mi"`                                                                                                                                                                                                                                                                                                                                      | Ephemeral volume size limit                                                                                                                                                                                                              |
| volumes.ephemeral.storageClassName           | `""`                                                                                                                                                                                                                                                                                                                                         | Ephemeral volume storage class name for `storage` type                                                                                                                                                                                   |
| volumes.ephemeral.custom                     | `{}`                                                                                                                                                                                                                                                                                                                                         | Custom definition of the ephemeral volume for `custom` type                                                                                                                                                                              |
| registerAdmin.enabled                        | `true`                                                                                                                                                                                                                                                                                                                                       | Whether the administrator should be registered                                                                                                                                                                                           |
| registerAdmin.source                         | `external`                                                                                                                                                                                                                                                                                                                                   | Source of the administrator certificate: <ul> <li>`external` means that the certificate is provided in `registerAdmin.admin.certificate`</li> <li>`internal` will generate internal CA and generate administrator certificate</li> </ul> |
| registerAdmin.admin.certificate              | `"CZERTAINLY Administrator"`                                                                                                                                                                                                                                                                                                                 | Administrator certificate in PEM format                                                                                                                                                                                                  |
| registerAdmin.admin.description              | `"First Administrator"`                                                                                                                                                                                                                                                                                                                      | Description for the administrator                                                                                                                                                                                                        |
| registerAdmin.admin.username                 | `"czertainly-admin"`                                                                                                                                                                                                                                                                                                                         | Initial administrator username                                                                                                                                                                                                           |
| registerAdmin.admin.password                 | `"your-strong-password"`                                                                                                                                                                                                                                                                                                                     | Initial administrator password                                                                                                                                                                                                           |
| registerAdmin.admin.name                     | `"admin"`                                                                                                                                                                                                                                                                                                                                    | Initial administrator first name                                                                                                                                                                                                         |
| registerAdmin.admin.surname                  | `"admin"`                                                                                                                                                                                                                                                                                                                                    | Initial administrator last name                                                                                                                                                                                                          |
| registerAdmin.admin.email                    | `"admin@czertainly.local"`                                                                                                                                                                                                                                                                                                                   | Initial administrator email                                                                                                                                                                                                              |
| logging.level                                | `"INFO"`                                                                                                                                                                                                                                                                                                                                     | Allowed values are `"INFO"`, `"DEBUG"`, `"WARN"`, `"TRACE"`                                                                                                                                                                              |
| logging.audit.enabled                        | `"false"`                                                                                                                                                                                                                                                                                                                                    | Whether audit log is enabled                                                                                                                                                                                                             |
| hostname                                     | `czertainly.local`                                                                                                                                                                                                                                                                                                                           | Hostname (FQDN) for the platform                                                                                                                                                                                                         |
| ingress.enabled                              | `false`                                                                                                                                                                                                                                                                                                                                      | Install ingress resource                                                                                                                                                                                                                 |
| ingress.certificate.source                   | `internal`                                                                                                                                                                                                                                                                                                                                   | Source for the ingress TLS certifiacate: <ul> <li>`external` for certificate provided as secret defined in `ingress.tls.secretName`</li> <li>`internal` will generate internal CA and TLS certificate to be used</li> </ul>              |
| ingress.class                                | `nginx`                                                                                                                                                                                                                                                                                                                                      | Class name of ingress                                                                                                                                                                                                                    |
| ingress.annotations                          | `{ nginx.ingress.kubernetes.io/backend-protocol: "HTTP", nginx.ingress.kubernetes.io/auth-tls-verify-client: "optional",nginx.ingress.kubernetes.io/auth-tls-secret: "czertainly/trusted-certificates", nginx.ingress.kubernetes.io/auth-tls-verify-depth: "3", nginx.ingress.kubernetes.io/auth-tls-pass-certificate-to-upstream: "true" }` | Additional annotations to customize the ingress                                                                                                                                                                                          |
| ingress.tls.secretName                       | `czertainly-ingress-tls`                                                                                                                                                                                                                                                                                                                     | Ingress TLS certificate and private key secret name                                                                                                                                                                                      |
| registerConnectors                           | `true`                                                                                                                                                                                                                                                                                                                                       | Whether the connector should be auto-registered in the platform                                                                                                                                                                          |
| commonCredentialProvider.enabled             | `true`                                                                                                                                                                                                                                                                                                                                       | Whether the Common Credential Provider should be enabled                                                                                                                                                                                 |
| ejbcaNgConnector.enabled                     | `false`                                                                                                                                                                                                                                                                                                                                      | Whether the EJBCA NG Connector should be enabled                                                                                                                                                                                         |
| msAdcsConnector.enabled                      | `false`                                                                                                                                                                                                                                                                                                                                      | Whether the MS ADCS Connector should be enabled                                                                                                                                                                                          |
| x509ComplianceProvider.enabled               | `false`                                                                                                                                                                                                                                                                                                                                      | Whether the X.509 Compliance Provider should be enabled                                                                                                                                                                                  |
| cryptosenseDiscoveryProvider.enabled         | `false`                                                                                                                                                                                                                                                                                                                                      | Whether the Cryptosense Discovery Provider should be enabled                                                                                                                                                                             |
| networkDiscoveryProvider.enabled             | `false`                                                                                                                                                                                                                                                                                                                                      | Whether the Network Discovery Provider should be enabled                                                                                                                                                                                 |
| keystoreEntityProvider.enabled               | `false`                                                                                                                                                                                                                                                                                                                                      | Whether the Keystore Entity Provider should be enabled                                                                                                                                                                                   |
| softwareCryptographyProvider.enabled         | `false`                                                                                                                                                                                                                                                                                                                                      | Whether the Software Cryptography Provider should be enabled                                                                                                                                                                             |
| utilsService.enabled                         | `false`                                                                                                                                                                                                                                                                                                                                      | Enables optional utils service                                                                                                                                                                                                           |
| auth.header.token                            | `"X-USERINFO"`                                                                                                                                                                                                                                                                                                                               | Name of the header containing JSON ID                                                                                                                                                                                                    |
| auth.header.certificate                      | `"X-APP-CERTIFICATE"`                                                                                                                                                                                                                                                                                                                        | Name of the header containing client certificate                                                                                                                                                                                         |
| javaOpts                                     | `""`                                                                                                                                                                                                                                                                                                                                         | Customize Java system properties                                                                                                                                                                                                         |

#### Parameters for associated containers

**Open Policy Agent**

| Parameter                                        | Default value                | Description                                         |
|--------------------------------------------------|------------------------------|-----------------------------------------------------|
| opa.image.registry                               | `docker.io`                  | Docker registry name for the image                  |
| opa.image.repository                             | `openpolicyagent/opa`        | Docker image repository name                        |
| opa.image.tag                                    | `0.45.0-rootless`            | Docker image tag                                    |
| opa.image.digest                                 | `""`                         | Docker image digest, will override tag if specified |
| opa.image.pullPolicy                             | `IfNotPresent`               | Image pull policy                                   |
| opa.image.pullSecrets                            | `[]`                         | Array of secret names for image pull                |
| opa.image.securityContext.runAsNonRoot           | `true`                       | Run the container as non-root user                  |
| opa.image.securityContext.runAsUser              | `1000`                       | User ID for the container                           |
| opa.image.securityContext.readOnlyRootFilesystem | `true`                       | Run the container with read-only root filesystem    |
| opa.image.resources.requests                     | `cpu: 50m`<br>`memory: 150M` | The requested resources for the container           |
| opa.image.resources.limits                       | `{}`                         | The resources limits for the container              |

**cURL**

| Parameter                                         | Default value     | Description                                         |
|---------------------------------------------------|-------------------|-----------------------------------------------------|
| curl.image.registry                               | `docker.io`       | Docker registry name for the image                  |
| curl.image.repository                             | `curlimages/curl` | Docker image repository name                        |
| curl.image.tag                                    | `7.87.0`          | Docker image tag                                    |
| curl.image.digest                                 | `""`              | Docker image digest, will override tag if specified |
| curl.image.pullPolicy                             | `IfNotPresent`    | Image pull policy                                   |
| curl.image.pullSecrets                            | `[]`              | Array of secret names for image pull                |
| curl.image.securityContext.runAsNonRoot           | `true`            | Run the container as non-root user                  |
| curl.image.securityContext.runAsUser              | `100`             | User ID for the container                           |
| curl.image.securityContext.readOnlyRootFilesystem | `true`            | Run the container with read-only root filesystem    |

**kubectl**

| Parameter                                            | Default value     | Description                                         |
|------------------------------------------------------|-------------------|-----------------------------------------------------|
| kubectl.image.registry                               | `docker.io`       | Docker registry name for the image                  |
| kubectl.image.repository                             | `bitnami/kubectl` | Docker image repository name                        |
| kubectl.image.tag                                    | `1.26.1`          | Docker image tag                                    |
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

**Open Policy Agent**

| Parameter                                      | Default value | Description                                                                        |
|------------------------------------------------|---------------|------------------------------------------------------------------------------------|
| opa.image.probes.liveness.enabled              | `true`        | Enable/disable liveness probe                                                      |
| opa.image.probes.liveness.custom               | `{}`          | Custom liveness probe command. When defined, it will override the default command  |
| opa.image.probes.liveness.initialDelaySeconds  | `5`           | Initial delay seconds for liveness probe                                           |
| opa.image.probes.liveness.timeoutSeconds       | `5`           | Timeout seconds for liveness probe                                                 |
| opa.image.probes.liveness.periodSeconds        | `10`          | Period seconds for liveness probe                                                  |
| opa.image.probes.liveness.successThreshold     | `1`           | Success threshold for liveness probe                                               |
| opa.image.probes.liveness.failureThreshold     | `3`           | Failure threshold for liveness probe                                               |
| opa.image.probes.readiness.enabled             | `true`        | Enable/disable readiness probe                                                     |
| opa.image.probes.readiness.custom              | `{}`          | Custom readiness probe command. When defined, it will override the default command |
| opa.image.probes.readiness.initialDelaySeconds | `5`           | Initial delay seconds for readiness probe                                          |
| opa.image.probes.readiness.timeoutSeconds      | `5`           | Timeout seconds for readiness probe                                                |
| opa.image.probes.readiness.periodSeconds       | `10`          | Period seconds for readiness probe                                                 |
| opa.image.probes.readiness.successThreshold    | `1`           | Success threshold for readiness probe                                              |
| opa.image.probes.readiness.failureThreshold    | `3`           | Failure threshold for readiness probe                                              |
| opa.image.probes.startup.enabled               | `false`       | Enable/disable startup probe                                                       |
| opa.image.probes.startup.custom                | `{}`          | Custom startup probe command. When defined, it will override the default command   |
| opa.image.probes.startup.initialDelaySeconds   | `5`           | Initial delay seconds for startup probe                                            |
| opa.image.probes.startup.timeoutSeconds        | `5`           | Timeout seconds for startup probe                                                  |
| opa.image.probes.startup.periodSeconds         | `10`          | Period seconds for startup probe                                                   |
| opa.image.probes.startup.successThreshold      | `1`           | Success threshold for startup probe                                                |
| opa.image.probes.startup.failureThreshold      | `3`           | Failure threshold for startup probe                                                |

> **Note**
> TBD - additional description of the values, should be improved

### Additional parameters

Additional parameters may be found in the [values.yaml](values.yaml) and dependencies.
See dependent charts for the description of available parameters.

## Troubleshooting

### Timed out waiting for the condition

When the installation or upgrade fails with the following reason:
```bash
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
```
It is most probably because of reaching the default Helm timeout during deployment when Helm is trying to download all missing container images. This should not happen when you have all required container images already present on the target cluster.

If you are facing timeout issues, increase the Helm timeout using `--timeout` switch, for example:
```bash
helm install --namespace czertainly -f czertainly-values.yaml --set-file trusted.certificates=trusted-certificates.pem czertainly-tlm oci://harbor.3key.company/czertainly-helm/czertainly --timeout 1h
```

### It seems that I cannot log in with my generated administrator certificate

When you have installed the CZERTAINLY usign the auto-generated internal admin CA and issued administrator certificate for your registered administrator, it may happen that you overrride the list of trusted certificates and miss the create internal admin CA certificate. In this case, read the admin CA certificate, include it in the list of trusted certificates, and upgrade the configuration of the CZERTAINLY. You can use the following command to get the admin CA certificate in PEM format in file `admin-ca-certificate.pem`:

```bash
kubectl get secrets --namespace czertainly admin-ca-keypair -o jsonpath='{.data.tls\.crt}' | base64 --decode > admin-ca-certificate.pem
```

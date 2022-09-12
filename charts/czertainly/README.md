# CZERTAINLY-Helm-Charts

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.2.0+
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

**Add Helm chart repository**

Use `helm repo add` command to add the Helm chart repository that contains charts to install CZERTAINLY:
```bash
helm repo add --username=username harbor3key https://harbor.3key.company/chartrepo/czertainly
```

**Create namespace**

We’ll need to define a Kubernetes namespace where the resources created by the Chart should be installed:
```bash
kubectl create namespace czertainly
```

**Create `czertainly-values.yaml**

Copy the default `values.yaml` from the CZERTAINLY Helm chart and modify the values accordingly:
```bash
helm show values harbor3key/czertainly > czertainly-values.yaml
```
Now edit the `czertainly-values.yaml` according to your desired stated, see [Configurable parameters](#configurable-parameters) for more information.

**Prepare list of trusted CA certificates**

Create new file called `trusted-certificates.pem` and add to the file PEM certificates of all certification authorities that should be trusted by the platform. No worries, you can always change the list of trusted certificates in the future. See the sample [trusted-certificates](../../samples/trusted-certificates.pem) file.

The list of trusted certificates is need for the installation of the CZERTAINLY using Helm chart.

**Install CZERTAINLY**

There are couple of options to install CZERTAINLY based on you TLS configuration and administrator certificate handling. See the [Configurable parameters](#configurable-parameters) for more information.

For the basic installation, run:
```bash
helm install --namespace czertainly -f czertainly-values.yaml --set-file trusted.certificates=trusted-certificates.pem czertainly-tlm harbor3key/czertainly
```

**Save your configuration**

Always make sure you save the `czertainly-values.yaml` and all `--set` and `--set-file` options you used. You will need to use the same options when you upgrade CZERTAINLY to new versions with Helm. In case you are changing the configuration, save the new configuration.

### Upgrade

> **Warning**
> Be sure that you always save your previous configuration!

For upgrading the CZERTAINLY installation, update your configuration and run:
```bash
helm upgrade --namespace czertainly -f czertainly-values.yaml --set-file trusted.certificates=trusted-certificates.pem czertainly-tlm harbor3key/czertainly
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

| Parameter                   | Default value                | Description                                                                       |
|-----------------------------|------------------------------|-----------------------------------------------------------------------------------|
| global.imagePullSecrets     | `[]`                         | Name of the registered credential as a secret to access private CZERTAINLY images |
| global.database.type        | `"postgresql"`               | Type of the database, currently only `postgresql` is supported                    |
| global.database.host        | `"host.docker.internal"`     | Host where is the database located                                                |
| global.database.port        | `"5432"`                     | Port on which is the database listening                                           |
| global.database.name        | `"czertainlydb"`             | Database name                                                                     |
| global.database.username    | `"czertainlyuser"`           | Username to access the database                                                   |
| global.database.password    | `"your-strong-password"`     | Password to access the database                                                   |
| global.trusted.certificates | `"CZERTAINLY Dummy Root CA"` | List of additional CA certificates that should be trusted                         |
| global.httpProxy            | `""`                         | Proxy to be used to access external resources through http                        |
| global.httpsProxy           | `""`                         | Proxy to be used to access external resources through https                       |
| global.httpProxy            | `""`                         | Defines list of external resources that should not use proxy settings             |

### Core parameters

The following values may be configured for the CZERTAINLY core service:

| Parameter                        | Default value                                                                                                                                                                                                                                                                                                                                | Description                                                                                                                                                                                                                              |
|----------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| registerAdmin.enabled            | `true`                                                                                                                                                                                                                                                                                                                                       | Whether the administrator should be registered                                                                                                                                                                                           |
| registerAdmin.source             | `external`                                                                                                                                                                                                                                                                                                                                   | Source of the administrator certificate: <ul> <li>`external` means that the certificate is provided in `registerAdmin.admin.certificate`</li> <li>`internal` will generate internal CA and generate administrator certificate</li> </ul> |
| registerAdmin.admin.certificate  | `"CZERTAINLY Administrator"`                                                                                                                                                                                                                                                                                                                 | Administrator certificate in PEM format                                                                                                                                                                                                  |
| registerAdmin.admin.username     | `"czertainly-admin"`                                                                                                                                                                                                                                                                                                                         | Username of the administrator                                                                                                                                                                                                            |
| registerAdmin.admin.name         | `"admin"`                                                                                                                                                                                                                                                                                                                                    | Name of the administrator                                                                                                                                                                                                                |
| registerAdmin.admin.surname      | `"admin"`                                                                                                                                                                                                                                                                                                                                    | Surname of the administrator                                                                                                                                                                                                             |
| registerAdmin.admin.email        | `"admin@czertainly.local"`                                                                                                                                                                                                                                                                                                                   | Email of the administrator                                                                                                                                                                                                               |
| registerAdmin.admin.description  | `"First Administrator"`                                                                                                                                                                                                                                                                                                                      | Description for the administrator                                                                                                                                                                                                        |
| logging.level                    | `"INFO"`                                                                                                                                                                                                                                                                                                                                     | Allowed values are `"INFO"`, `"DEBUG"`, `"WARN"`, `"TRACE"`                                                                                                                                                                              |
| hostname                         | `localhost`                                                                                                                                                                                                                                                                                                                                  | Hostname (FQDN) for the platform                                                                                                                                                                                                         |
| ingress.enabled                  | `false`                                                                                                                                                                                                                                                                                                                                      | Install ingress resource                                                                                                                                                                                                                 |
| ingress.certificate.source       | `internal`                                                                                                                                                                                                                                                                                                                                   | Source for the ingress TLS certifiacate: <ul> <li>`external` for certificate provided as secret defined in `ingress.tls.secretName`</li> <li>`internal` will generate internal CA and TLS certificate to be used</li> </ul>              |
| ingress.class                    | `nginx`                                                                                                                                                                                                                                                                                                                                      | Class name of ingress                                                                                                                                                                                                                    |
| ingress.annotations              | `{ nginx.ingress.kubernetes.io/backend-protocol: "HTTP", nginx.ingress.kubernetes.io/auth-tls-verify-client: "optional",nginx.ingress.kubernetes.io/auth-tls-secret: "czertainly/trusted-certificates", nginx.ingress.kubernetes.io/auth-tls-verify-depth: "3", nginx.ingress.kubernetes.io/auth-tls-pass-certificate-to-upstream: "true" }` | Additional annotations to customize the ingress                                                                                                                                                                                          |
| ingress.tls.secretName           | `czertainly-ingress-tls`                                                                                                                                                                                                                                                                                                                     | Ingress TLS certificate and private key secret name                                                                                                                                                                                      |
| registerConnectors               | `true`                                                                                                                                                                                                                                                                                                                                       | Whether the connector should be auto-registered in the platform                                                                                                                                                                          |
| commonCredentialProvider.enabled | `true`                                                                                                                                                                                                                                                                                                                                       | Whether the Common Credential Provider should be enabled                                                                                                                                                                                 |
| ejbcaNgConnector.enabled         | `true`                                                                                                                                                                                                                                                                                                                                       | Whether the EJBCA NG Connector should be enabled                                                                                                                                                                                         |

> **Note**
> TBD - additional description of the values, should be improved

### Additional parameters

Additional parameters may be found in the [values.yaml](values.yaml) and dependencies.
See dependent charts for the description of available parameters.

## Troubleshooting

### It seems that I cannot log in with my generated administrator certificate

When you have installed the CZERTAINLY usign the auto-generated internal admin CA and issued administrator certificate for your registered administrator, it may happen that you overrride the list of trusted certificates and miss the create internal admin CA certificate. In this case, read the admin CA certificate, include it in the list of trusted certificates, and upgrade the configuration of the CZERTAINLY. You can use the following command to get the admin CA certificate in PEM format in file `admin-ca-certificate.pem`:

```bash
kubectl get secrets --namespace czertainly admin-ca-keypair -o jsonpath='{.data.tls\.crt}' | base64 --decode > admin-ca-certificate.pem
```
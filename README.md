# CZERTAINLY-Helm-Charts

> This repository is part of the commercial open-source project CZERTAINLY, but the connector is available under subscription. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

## Prerequisites
- Kubernetes 1.19+
- Helm 3.2.0+

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

Create new file called `trusted-certificates.pem` and add to the file PEM certificates of all certification authorities that should be trusted by the platform. No worries, you can always change the list of trusted certificates in the future. See the sample [trusted-certificates](samples/trusted-certificates.pem) file.

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

You can find current values in the [values.yaml](charts/czertainly/values.yaml).
You can also Specify each parameter using the `--set` or `--set-file` argument to `helm install`.

> **Note**
> TBD

### Global parameters

Global values are used to define common parameters for the chart and all its sub-charts by exactly the same name.

| Parameter                | Default value                                                                           | Description                                                                       |
|--------------------------|-----------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| global.imagePullSecrets  | `[]`                                                                                    | Name of the registered credential as a secret to access private CZERTAINLY images |
| global.database.jdbUrl   | `"jdbc:postgresql://host.docker.internal:5432/czertainlylocal?characterEncoding=UTF-8"` | JDBC URL format to access the database                                            |
| global.database.username | `"czertainlyuser"`                                                                      | Username to access the database                                                   |
| global.database.password | `"your-strong-password"`                                                                | Password to access the database                                                   |

### Core parameters

> **Note**
> TBD

### Additional parameters

> **Note**
> TBD

## Troubleshooting

### It seems that I cannot log in with my generated administrator certificate

When you have installed the CZERTAINLY usign the auto-generated internal admin CA and issued administrator certificate for your registered administrator, it may happen that you overrride the list of trusted certificates and miss the create internal admin CA certificate. In this case, read the admin CA certificate, include it in the list of trusted certificates, and upgrade the configuration of the CZERTAINLY. You can use the following command to get the admin CA certificate in PEM format in file `admin-ca-certificate.pem`:

```bash
kubectl get secrets --namespace czertainly admin-ca-keypair -o jsonpath='{.data.tls\.crt}' | base64 --decode > admin-ca-certificate.pem
```
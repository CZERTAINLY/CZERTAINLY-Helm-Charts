# CZERTAINLY-Helm-Charts

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/CZERTAINLY/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

## Quick start

Use the [CZERTAINLY Chart](charts/czertainly) to deploy the platform.

## Structure of the charts

The charts are built in a way that you can install them separately, if you want.
There is one global [CZERTAINLY Chart](charts/czertainly) that acts as umbrella chart for the platform. You can use it to install complete platform including selected sub-charts as components of the platform.

### List of charts

**Library**
- [CZERTAINLY Library](charts/czertainly-lib)

**Core**
- [CZERTAINLY](charts/czertainly) (**umbrella chart**)
- [Auth Service](charts/auth-service)
- [Auth OPA Policies](charts/auth-opa-policies)
- [Messaging RabbitMQ](charts/messaging-rabbitmq)

**API Gateways**
- [API Gateway HAProxy](charts/api-gateway-haproxy) (**deprecated**)
- [API Gateway Kong](charts/api-gateway-kong)

**Front ends**
- [FE Administrator](charts/fe-administrator)

**Connectors**
- [Common Credential Provider](charts/common-credential-provider)
- [EJBCA NG Connector](charts/ejbca-ng-connector)
- [PyADCS Connector](charts/pyadcs-connector)
- [HashiCorp Vault Connector](charts/hashicorp-vault-connector)
- [MS ADCS Connector](charts/ms-adcs-connector) (**deprecated**)
- [X.509 Compliance Provider](charts/x509-compliance-provider)
- [Network Discovery Provider](charts/network-discovery-provider)
- [Cryptosense Discovery Provider](charts/cryptosense-discovery-provider)
- [CT Logs Discovery Provider](charts/ct-logs-discovery-provider)
- [Keystore Entity Provider](charts/keystore-entity-provider)
- [Software Cryptography Provider](charts/software-cryptography-provider)

**Optional components**

- [Keycloak Internal](charts/keycloak-internal) (internal Keycloak instance that can be used for authentication through OIDC and connect with various identity providers)
> :warning:
> For internal Keycloak to process request properly, it is important to have hostname of the CZERTAINLY platform included in the DNS resolver.
> For local testing, you can upgrade the CZERTAINLY chart with the `--set apiGateway.hostAliases.resolveInternalKeycloak=true`. This will resolve the internal Keycloak inside the cluster with proper IP address.

- [Utils Service](charts/utils-service) (service that provides various utility functions for the platform)

## Private containers

Some charts may use container images that are part of the private repositories.
In this case it is necessary to provide reference to secret as part of the `imagePullSecrets`.

You can use the following command to create such secret in your namespace:
```bash
kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```

For more information, see [Create a Secret by providing credentials on the command line](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#create-a-secret-by-providing-credentials-on-the-command-line).

## CZERTAINLY Dummy Root CA and certificates

The dummy certification authority is pre-built in this repository that can be used for development and testing purposes.
You can find it in the [dummy-certificates](dummy-certificates).

The dummy certificates are included by default in the values of the Helm charts. You can install platform with the dummy certificates and access its functions.
Dummy CA can be replaced anytime.

## Samples

You can find some samples in the [samples](samples).
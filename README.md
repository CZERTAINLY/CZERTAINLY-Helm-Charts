# CZERTAINLY-Helm-Charts

> This repository is part of the commercial open-source project CZERTAINLY. You can find more information about the project at [CZERTAINLY](https://github.com/3KeyCompany/CZERTAINLY) repository, including the contribution guide.

This repository contains [Helm](https://helm.sh/) charts as part of the CZERTAINLY platform.

## Quick start

Use the [CZERTAINLY Chart](charts/czertainly) to deploy the platform.

## Structure of the charts

The charts are built in a way that you can install them separately, if you want.
There is one global [CZERTAINLY Chart](charts/czertainly) that acts as umbrella chart for the platform. You can use it to install complete platform including selected sub-charts as components of the platform.

### List of charts

- [CZERTAINLY](charts/czertainly)
- [CZERTAINLY Library](charts/czertainly-lib)
- [API Gateway HAProxy](charts/api-gateway-haproxy)
- [FE Administrator](charts/fe-administrator)
- [Common Credential Provider](charts/common-credential-provider)
- [EJBCA NG Connector](charts/ejbca-ng-connector)

## CZERTAINLY Dummy Root CA and certificates

The dummy certification authority is pre-built in this repository that can be used for development and testing purposes.
You can find it in the [dummy-certificates](dummy-certificates).

The dummy certificates are included by default in the values of the Helm charts. You can install platform with the dummy certificates and access its functions.
Dummy CA can be replaced anytime.

## Samples

You can find some samples in the [samples](samples).
#!/bin/sh

# czertainly-lib is always the first as it is used by other charts
helm dependency update charts/czertainly-lib

# next, we should update dependencies for all sub-charts
# helm dependency update charts/api-gateway-haproxy # this is deprecated
helm dependency update charts/api-gateway-kong
helm dependency update charts/auth-opa-policies
helm dependency update charts/auth-service
helm dependency update charts/common-credential-provider
helm dependency update charts/cryptosense-discovery-provider
helm dependency update charts/ejbca-ng-connector
helm dependency update charts/fe-administrator
helm dependency update charts/keycloak-internal
helm dependency update charts/keystore-entity-provider
helm dependency update charts/messaging-rabbitmq
helm dependency update charts/ms-adcs-connector
helm dependency update charts/network-discovery-provider
helm dependency update charts/scheduler-service
helm dependency update charts/software-cryptography-provider
helm dependency update charts/utils-service
helm dependency update charts/x509-compliance-provider

# finally, update czertainly umbrella chart
helm dependency update charts/czertainly
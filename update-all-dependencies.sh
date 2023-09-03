#!/bin/sh

# czertainly-lib is always the first as it is used by other charts
echo "Updating czertainly-lib dependencies..."
helm dependency update charts/czertainly-lib

# next, we should update dependencies for all sub-charts
# helm dependency update charts/api-gateway-haproxy # this is deprecated
echo "Updating dependencies for api-gateway-kong..."
helm dependency update charts/api-gateway-kong

echo "Updating dependencies for auth-opa-policies..."
helm dependency update charts/auth-opa-policies

echo "Updating dependencies for auth-service..."
helm dependency update charts/auth-service

echo "Updating dependencies for common-credential-provider..."
helm dependency update charts/common-credential-provider

echo "Updating dependencies for cryptosense-discovery-provider..."
helm dependency update charts/cryptosense-discovery-provider

echo "Updating dependencies for ejbca-ng-connector..."
helm dependency update charts/ejbca-ng-connector

echo "Updating dependencies for email-notification-provider..."
helm dependency update charts/email-notification-provider

echo "Updating dependencies for fe-administrator..."
helm dependency update charts/fe-administrator

echo "Updating dependencies for keycloak-internal..."
helm dependency update charts/keycloak-internal

echo "Updating dependencies for keystore-entity-provider..."
helm dependency update charts/keystore-entity-provider

echo "Updating dependencies for messaging-rabbitmq..."
helm dependency update charts/messaging-rabbitmq

echo "Updating dependencies for ms-adcs-connector..."
helm dependency update charts/ms-adcs-connector

echo "Updating dependencies for network-discovery-provider..."
helm dependency update charts/network-discovery-provider

echo "Updating dependencies for scheduler-service..."
helm dependency update charts/scheduler-service

echo "Updating dependencies for software-cryptography-provider..."
helm dependency update charts/software-cryptography-provider

echo "Updating dependencies for utils-service..."
helm dependency update charts/utils-service

echo "Updating dependencies for x509-compliance-provider..."
helm dependency update charts/x509-compliance-provider

# finally, update czertainly umbrella chart
echo "Updating dependencies for czertainly..."
helm dependency update charts/czertainly
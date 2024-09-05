#!/bin/sh

# czertainly-lib is always the first as it is used by other charts
echo "Updating czertainly-lib dependencies..."
helm dependency update charts/czertainly-lib --skip-refresh

# next, we should update dependencies for all sub-charts

# helm dependency update charts/api-gateway-haproxy # this is deprecated

echo "Updating dependencies for api-gateway-kong..."
helm dependency update charts/api-gateway-kong --skip-refresh

echo "Updating dependencies for auth-opa-policies..."
helm dependency update charts/auth-opa-policies --skip-refresh

echo "Updating dependencies for auth-service..."
helm dependency update charts/auth-service --skip-refresh

echo "Updating dependencies for common-credential-provider..."
helm dependency update charts/common-credential-provider --skip-refresh

echo "Updating dependencies for cryptosense-discovery-provider..."
helm dependency update charts/cryptosense-discovery-provider --skip-refresh

echo "Updating dependencies for cryptosense-discovery-provider..."
helm dependency update charts/ct-logs-discovery-provider --skip-refresh

echo "Updating dependencies for ejbca-ng-connector..."
helm dependency update charts/ejbca-ng-connector --skip-refresh

echo "Updating dependencies for email-notification-provider..."
helm dependency update charts/email-notification-provider --skip-refresh

echo "Updating dependencies for fe-administrator..."
helm dependency update charts/fe-administrator --skip-refresh

echo "Updating dependencies for hashicorp-vault-connector..."
helm dependency update charts/hashicorp-vault-connector --skip-refresh

echo "Updating dependencies for keycloak-internal..."
helm dependency update charts/keycloak-internal --skip-refresh

echo "Updating dependencies for keystore-entity-provider..."
helm dependency update charts/keystore-entity-provider --skip-refresh

echo "Updating dependencies for messaging-rabbitmq..."
helm dependency update charts/messaging-rabbitmq --skip-refresh

echo "Updating dependencies for ms-adcs-connector..."
helm dependency update charts/ms-adcs-connector --skip-refresh

echo "Updating dependencies for network-discovery-provider..."
helm dependency update charts/network-discovery-provider --skip-refresh

echo "Updating dependencies for pyadcs-connector..."
helm dependency update charts/pyadcs-connector --skip-refresh

echo "Updating dependencies for scheduler-service..."
helm dependency update charts/scheduler-service --skip-refresh

echo "Updating dependencies for software-cryptography-provider..."
helm dependency update charts/software-cryptography-provider --skip-refresh

echo "Updating dependencies for utils-service..."
helm dependency update charts/utils-service --skip-refresh

echo "Updating dependencies for x509-compliance-provider..."
helm dependency update charts/x509-compliance-provider --skip-refresh

# finally, update czertainly umbrella chart
echo "Updating dependencies for czertainly..."
helm dependency update charts/czertainly --skip-refresh
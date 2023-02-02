#!/bin/sh

CHART_NAME=$1
VERSION=$2

helm dependency update charts/$CHART_NAME
helm package charts/$CHART_NAME
helm push $CHART_NAME-$VERSION.tgz oci://harbor.3key.company/czertainly-helm

#!/bin/sh

CHART=$1

name=$(yq ".name" < ${CHART}/Chart.yaml)
version=$(yq ".version" < ${CHART}/Chart.yaml)

echo "Releasing chart $CHART with version $version"

helm dependency update $CHART
helm package $CHART
helm push $name-$version.tgz oci://$HELM_OCI_REGISTRY/$HELM_OCI_REPOSITORY

echo "Chart $name-$version pushed"

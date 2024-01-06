#!/bin/bash

cd $PROJECT

VERSION=$(grep -oPm1 "(?<=<version>)[^<]+" pom.xml)

echo "Build new image $QUAY_URL/$QUAY_USER/$PROJECT:$VERSION"
buildah --storage-driver=vfs build \
    --format=docker \
    --tls-verify=false \
    --no-cache \
    -f Dockerfile \
    -t $QUAY_URL/$QUAY_USER/$PROJECT:$VERSION \
    .

echo "Login in Quay"
buildah login --tls-verify=false -u $QUAY_USER -p $QUAY_PASS $QUAY_URL

echo "Push new image $QUAY_URL/$QUAY_USER/$PROJECT:$VERSION"
buildah --storage-driver=vfs push \
    --tls-verify=false \
    $QUAY_URL/$QUAY_USER/$PROJECT:$VERSION \
    docker://$QUAY_URL/$QUAY_USER/$PROJECT:$VERSION

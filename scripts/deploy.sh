#!/bin/bash

cd $PROJECT

VERSION=$(grep -oPm1 "(?<=<version>)[^<]+" pom.xml)

echo "Replacing kustomize file for environment $ENVIRONMENT"
sed -i "s/newName: \S*/newName: $QUAY_URL\/$QUAY_USER\/$PROJECT/g" .devops/openshift/app/kustomize/overlays/$ENVIRONMENT/kustomization.yaml
sed -i "s/newTag: \S*/newTag: $VERSION/g" .devops/openshift/app/kustomize/overlays/$ENVIRONMENT/kustomization.yaml

echo "Deploy in $ENVIRONMENT new version $VERSION"
git add .
git commit -m "Deploy in $ENVIRONMENT version $NEW_VERSION"
git push origin
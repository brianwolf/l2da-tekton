#!/bin/bash

cd $PROJECT

echo "Making new version tag"
ACTUAL_VERSION=$(grep -oPm1 "(?<=<version>)[^<]+" pom.xml)

MAYOR="$(echo $ACTUAL_VERSION | cut -d'.' -f1)"
MINOR="$(echo $ACTUAL_VERSION | cut -d'.' -f2)"
PATCH="$(echo $ACTUAL_VERSION | cut -d'.' -f3)"

NEW_VERSION=$MAYOR.$((MINOR + 1)).$PATCH
echo "From $ACTUAL_VERSION to $NEW_VERSION"

echo "Changing new version in POM"
sed -i "s/<version>$ACTUAL_VERSION/<version>$NEW_VERSION/g" pom.xml

echo "Pushing new version tag"
git add .
git commit -m "New version $NEW_VERSION"
git push origin
git tag $NEW_VERSION
git push origin --tags
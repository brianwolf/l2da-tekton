#!/bin/bash

rm -fr $PROJECT

URL_WITH_CREDENTIALS="https://"${GIT_USER}:${GIT_PASS}@${URL#"https://"}

echo "git clone -b $BRANCH $URL_WITH_CREDENTIALS $PROJECT"
git clone -b $BRANCH $URL_WITH_CREDENTIALS $PROJECT
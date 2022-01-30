#!/usr/bin/env bash

echo "version=${1}" > release-trigger
echo "preRelease=${2}" >> release-trigger
# If you want to test the deployment, you may optionally add a suffix to the docker image tag
echo "tagSuffix=" >> release-trigger

git add .
git commit -m"trigger GitHub action docker-publish for ${1}"
git push

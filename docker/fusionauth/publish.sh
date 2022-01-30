#!/usr/bin/env bash

echo "version=${1}" > release-trigger
echo "preRelease=${2}" >> release-trigger
# If you want to test the deployment, you may optionally add a suffix to the docker image tag
echo "tagSuffix=" >> release-trigger

git add .
# Note, this commit message will show up as the title of the GH action workflow run
git commit -m"Publish ${1}"
git push

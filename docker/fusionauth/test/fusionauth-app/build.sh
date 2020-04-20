#!/bin/sh

cd ~/dev/inversoft/fusionauth/fusionauth-app || exit 1
sb bundle --zipOnly
cd - || exit 1
rm -rf ./fusionauth-app
unzip ~/dev/inversoft/fusionauth/fusionauth-app/build/bundles/fusionauth-app-*.zip -d ./fusionauth-app
docker build -t fusionauth/fusionauth-app:dev .

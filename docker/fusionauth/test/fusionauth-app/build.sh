#!/bin/sh

currentDir=`pwd`
cd ~/dev/inversoft/fusionauth/fusionauth-app
sb bundle
cd ${currentDir}
cp ~/dev/inversoft/fusionauth/fusionauth-app/build/bundles/fusionauth-app-*.zip .
docker build -t fusionauth/fusionauth-app:dev .

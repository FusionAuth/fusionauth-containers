# FusionAuth Docker
Dockerfiles and compose files for build and test of the FusionAuth app docker image.

## fusionauth-app
The fusionauth-app Dockerfile

### Usage

Build:
```
docker pull ubuntu:focal
docker build -t fusionauth/fusionauth-app:1.27.3 .
docker build -t fusionauth/fusionauth-app:latest .
```

Run:
```
docker run -p 9011:9011 -it fusionauth/fusionauth-app
```

Publish:
```
docker push fusionauth/fusionauth-app:1.27.3
docker push fusionauth/fusionauth-app:latest
```

## fusionauth-app-mysql
Adds a runtime download of the MySQL JDBC connector to the `fusionauth-app` docker image.

The MySQL JDBC connector is not bundled with FusionAuth due to the GPL
license terms under which Oracle publishes this software.

https://github.com/mysql/mysql-connector-j/blob/release/8.0/LICENSE

Because of this restriction, the MySQL connector is downloaded at runtime
to allow FusionAuth to connect to a MySQL JDBC URL.

Generally speaking downloading this jar at runtime works just fine. However
if you have blocked outbound network access or are concerned with this
external network dependency leading to possible failures during startup you
may optionally download the jar ahead of time.

During startup, if we identify the correct MySQL connector jar in the
classpath the download attempt will be skipped.

Re-packaging the FusionAuth Docker image with the MySQL connector is one
way of keeping this download from occurring at runtime.

### Usage
Build:
```
docker build -t fusionauth/fusionauth-app-mysql:1.27.3 .
docker build -t fusionauth/fusionauth-app-mysql:latest .
```

Run:
```
docker run -p 9011:9011 -it fusionauth/fusionauth-app-mysql
```

### License
Copyright 2021 FusionAuth, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
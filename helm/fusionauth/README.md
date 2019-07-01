# FusionAuth

[FusionAuth](https://fusionauth.io/) is a modern platform for Customer Identity and Access Management (CIAM). FusionAuth provides APIs and a responsive web user interface to support login, registration, localized email, multi-factor authentication, reporting and much more.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install . --name my-release
```

The command deploys FusionAuth and all dependencies (elasticsearch, postgresql) on the Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Migrations

We use flyway for database migrations as a job

## Configuration

The following table lists the configurable parameters of the FusionAuth chart and their default values.

Parameter | Description | Default
--- | --- | ---
`data.memory` | The RAM to assign to the Java VM for FusionAuth. Setting this environment variable will override the fusionauth-app.memory in the Configuration file. See the Configuration Reference for more information. | `256M`
`data.database.host` | The database host. Default is empty. If you want to use your own database instance you need to set `postgres.enabled` to false and set the database host | `nil`
`data.database.port` | The database port. The default port is 5432 | `5432`
`data.database.name` | The database name. The default jdbc connection string will be: `jdbc:postgresql://<<release-name>>-postgresql:5432/fusionauth` | `fusionauth`
`data.database.user` | The database user that will be created during configuration to own the FusionAuth schema and to connect to the database at FusionAuth runtime. Setting this environment variable will override the database.username in the Configuration file. See the Configuration Reference for more information. | `localhost`
`data.database.password` | The database password that will be created during configuration to own the FusionAuth schema and to connect to the database at FusionAuth runtime. If you are deploying this into production it is extremely important that you sent this value to something other than the default. Setting this environment variable will override the database.password in the Configuration file. See the Configuration Reference for more information. | `localhost`
`data.database.root.user` | The database root user that is used to create the FusionAuth schema and FusionAuth user. Once FusionAuth is configured and running this value is no longer used and is never persisted. | `localhost`
| `data.database.root.password` | The database root password that is used to create the FusionAuth schema and FusionAuth user. It is recommended to leave the value of this variable empty as it is shown in the example. Using this configuration, the value will be picked up from the host environment. To use the value in this way, be sure to set this named environment value before calling docker-compose up. Once FusionAuth is configured and running this value is no longer used and is never persisted. | `localhost`
`migrations.enabled` | If you want to execute database migrations eg. to add an initial user set `migrations.enabled` to `true` | `false`
`migrations.data` | SQL migrations that will be executed. See [values.yaml](values.yaml) for examples. | `nil`

All other user-configurable settings, default values and some commentary about them can be found in [values.yaml](values.yaml).


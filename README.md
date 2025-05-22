**Note: All procedures are assumed to be done from local for now**

## Pre-requisite

Below tool will be required when running on local pc.  
_Tested version_ in the table represents the version which I have used for testing.

| Tool name         | Tested version                                               |
|-------------------|--------------------------------------------------------------|
| java              | 11                                                           |
| flyway opensource | [11.7.2](https://github.com/flyway/flyway/tree/flyway-11.8.1) |
| docker engine     | 1:27.3.1-1                                                   |

## Build

```shell
docker build -t flyway:latest .
```

## Migrate

### To migrate bigquery

First setup flyway environment accordingly. Flyway required jdbc lib specific to biguqery (see [doc](https://documentation.red-gate.com/fd/google-bigquery-277579314.html)).
I used the [Command-line style of opensource version](https://documentation.red-gate.com/flyway/getting-started-with-flyway/quickstart-guides/quickstart-command-line).

Run migration.

Note: I relied on [google application credential](https://cloud.google.com/docs/authentication/application-default-credentials) for this purpose.

```shell
export GOOGLE_PROJECT_ID=$(gcloud config get core/project)
export GOOGLE_BQ_DATASET_LOCATION=asia-northeast1
make migrate
```

### To migrate Cloud sql

#### Before you begin

Make sure you apply resources.

https://github.com/yuwtennis/data-science-with-flights-iac

#### Do migration

Set up ssh tunnel to auth proxy.

```shell
gcloud compute ssh cloud-sql-auth-proxy \
  --tunnel-through-iap \
  --zone=asia-northeast1-a \
  --ssh-flag="-L 5432:localhost:5432"
```

Run migration.
```shell
export PG_USER=YOUR_USER
export PG_PASSWORD=YOUR_PASSWORD
docker run \
  -v $(pwd)/conf:/app/conf \
  -v $(pwd)/sql:/app/sql \
  --rm \
  -e PG_USER \
  -e PG_PASSWORD \
  flyway:latest \
  -environment=postgresql \
  -jarDirs=drivers \
  migrate
```
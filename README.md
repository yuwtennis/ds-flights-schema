**Note: All procedures are assumed to be done from local for now**

## Pre-requisite

Below tool will be required when running on local pc.  
_Tested version_ in the table represents the version which I have used for testing.

| Tool name         | Tested version                                                |
|-------------------|---------------------------------------------------------------|
| java              | 1.8.0_432                                                     |
| flyway opensource | [11.3.1](https://github.com/flyway/flyway/tree/flyway-11.3.1) |

## Migrate

### To migrate bigquery

First setup flyway environment accordingly. Flyway required jdbc lib specific to biguqery (see [doc](https://documentation.red-gate.com/fd/google-bigquery-277579314.html)).
I used the [Command-line style of opensource version](https://documentation.red-gate.com/flyway/getting-started-with-flyway/quickstart-guides/quickstart-command-line).

Run migration.

```shell
./flyway \
  -environment=bigquery\
  -jarDirs=drivers/bq \
  migrate
```

### To migrate Cloud sql

#### Before you begin

Make sure you apply resources.

https://github.com/yuwtennis/data-science-with-flights-iac

#### Do migration

Set up ssh tunnel to auth proxy.

```shell
gcloud compute ssh cloud-sql-auth-proxy \
  --tunnel-through-iap --zone=asia-northeast1-a --ssh-flag="-L 5432:localhost:5432"
```

Run migration.
```shell
./flyway \
  -environment=postgresql\
  -jarDirs=drivers\
  migrate
```
## Pre-requisite

Below tool will be required when running on local pc.  
_Tested version_ in the table represents the version which I have used for testing.

| Tool name         | Tested version                                                |
|-------------------|---------------------------------------------------------------|
| java              | 1.8.0_432                                                     |
| flyway opensource | [11.3.1](https://github.com/flyway/flyway/tree/flyway-11.3.1) |

## Migrate

Run DDL statements on bigquery

First setup flyway environment accordingly. Flyway required jdbc lib specific to biguqery (see [doc](https://documentation.red-gate.com/fd/google-bigquery-277579314.html)).
I used the [Command-line style of opensource version](https://documentation.red-gate.com/flyway/getting-started-with-flyway/quickstart-guides/quickstart-command-line).

To migrate bigquery
```shell
export JARDIR=drivers/bq
./flyway -environment=bigquery -jarDirs=$JARDIR migrate
```


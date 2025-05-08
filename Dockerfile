# syntax=docker/dockerfile:1
FROM debian:bookworm-slim AS build

ENV BQ_JDBC_DRIVER_VER=1.6.3.1004
ENV FLYWAY_CMD_LINE_VER=11.8.1
ENV BUILD_DIR=/build

RUN apt update && apt install -y -q unzip

ADD https://storage.googleapis.com/simba-bq-release/jdbc/SimbaJDBCDriverforGoogleBigQuery42_${BQ_JDBC_DRIVER_VER}.zip /tmp
ADD https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/${FLYWAY_CMD_LINE_VER}/flyway-commandline-${FLYWAY_CMD_LINE_VER}-linux-x64.tar.gz /tmp

RUN mkdir $BUILD_DIR
WORKDIR $BUILD_DIR

RUN tar xzv --strip-components=1 -f /tmp/flyway-commandline-${FLYWAY_CMD_LINE_VER}-linux-x64.tar.gz -C $BUILD_DIR
RUN mkdir -p ${BUILD_DIR}/jars/bq  \
    && unzip /tmp/SimbaJDBCDriverforGoogleBigQuery42_${BQ_JDBC_DRIVER_VER}.zip -d ${BUILD_DIR}/jars/bq

FROM amazoncorretto:11-al2023
# BQ JDBC DRIVER requires java 8 or 11

COPY --from=build /build /app
WORKDIR /app
ENTRYPOINT ["/app/flyway"]
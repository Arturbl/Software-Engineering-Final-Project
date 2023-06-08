FROM postgres:12.5
ENV LANG en_US.UTF-8

ENV POSTGRES_DB arduino-security-system-postgres-db

COPY init.sql /docker-entrypoint-initdb.d/

MAINTAINER Artur Costa
ENV PORT 5432
ENV POSTGRES_USER admin
ENV POSTGRES_PASSWORD admin
ENV PGDATA: /var/lib/postgresql/data/
ENV TZ=UTC
EXPOSE $PORT

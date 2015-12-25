#!/bin/bash

# Create certs for nginx
openssl req -x509 -nodes -days 3650 \
    -newkey rsa:2048 \
    -keyout nginx/sentry.key \
    -out nginx/sentry.crt

# Configure Sentry data directories

# Redis
if [ ! -d /data/redis ] ; then
	mkdir -p /data/redis
fi

# Postgres
if [ ! -d /data/postgres/etc ] ; then
	mkdir -p /data/postgres/etc
fi

if [ ! -d /data/postgres/log ] ; then
	mkdir -p /data/postgres/log
fi

if [ ! -d /data/postgres/lib/data ] ; then
	mkdir -p /data/postgres/lib/data
fi


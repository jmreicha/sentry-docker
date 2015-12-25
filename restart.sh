#!/usr/bin/env bash

# Bump the Sentry services

workdir=`pwd`
cd $workdir

# Stop Docker containers
docker-compose stop

# RM old containers
docker-compose rm --force

# Rebuild containers (with new configs if changed)
docker-compose build

# Start up fresh containers
docker-compose up -d

# Check if containers come up
sleep 3
docker-compose ps

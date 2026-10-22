#!/bin/bash
set -e

# Loads Arizona OpenStreetMap data into a database named "arizona" in PostGIS,
# the same import as Unit 6 Assignment 3.
# Run after PostGIS is up on the gist415 network (docker compose up in assignment-1/).

STATE=${1:-arizona}

docker run --rm --network gist415 \
  -e STATE="$STATE" \
  -e DATABASE="$STATE" \
  aaryno/populate-docker-geo populate-postgis.sh

echo "==> Done. In GeoServer, connect to PostGIS with:"
echo "    Host: postgis (container name, not localhost)"
echo "    Port: 5432"
echo "    Database: $STATE"
echo "    User: postgres / Password: postgres"

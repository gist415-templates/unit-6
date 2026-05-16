#!/bin/bash
set -e

# Downloads Arizona OSM data and imports it into PostGIS using osm2pgsql.
# Run after both PostGIS and GeoServer containers are up.

CONTAINER=${1:-postgis}
DB=gis
USER=postgres
REGION=arizona
OSM_URL="https://download.geofabrik.de/north-america/us/${REGION}-latest.osm.pbf"
TMP_DIR=$(mktemp -d)
PBF_FILE="$TMP_DIR/${REGION}-latest.osm.pbf"

echo "==> Downloading ${REGION} OSM data (~100-300 MB)..."
curl -L -o "$PBF_FILE" "$OSM_URL"

echo "==> Copying data into container..."
docker cp "$PBF_FILE" "$CONTAINER:/tmp/${REGION}.osm.pbf"

echo "==> Creating database and extensions..."
docker exec "$CONTAINER" psql -U "$USER" -c "DROP DATABASE IF EXISTS $DB;" 2>/dev/null || true
docker exec "$CONTAINER" psql -U "$USER" -c "CREATE DATABASE $DB;"
docker exec "$CONTAINER" psql -U "$USER" -d "$DB" -c "CREATE EXTENSION IF NOT EXISTS postgis;"
docker exec "$CONTAINER" psql -U "$USER" -d "$DB" -c "CREATE EXTENSION IF NOT EXISTS hstore;"

echo "==> Installing osm2pgsql in container..."
docker exec "$CONTAINER" apt-get update -qq
docker exec "$CONTAINER" apt-get install -y -qq osm2pgsql

echo "==> Importing OSM data (this may take several minutes)..."
docker exec "$CONTAINER" osm2pgsql \
  --database "$DB" \
  --username "$USER" \
  --host localhost \
  --slim \
  --hstore \
  /tmp/${REGION}.osm.pbf

echo "==> Verifying import..."
docker exec "$CONTAINER" psql -U "$USER" -d "$DB" -c "\dt"

echo "==> Done! Connect GeoServer to PostGIS:"
echo "    Host: postgis (container name, not localhost)"
echo "    Port: 5432"
echo "    Database: $DB"
echo "    User: $USER / Password: postgres"

rm -rf "$TMP_DIR"

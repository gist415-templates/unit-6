#!/bin/bash
set -e

# Downloads and loads the PostGIS NYC workshop dataset into the 'nyc' database.
# Run this after the container is up: bash scripts/populate_nyc.sh

CONTAINER=${1:-postgis}
DB=nyc
USER=postgres
TMP_DIR=$(mktemp -d)

echo "==> Downloading NYC workshop data..."
curl -L -o "$TMP_DIR/nyc_data.zip" \
  "https://s3.amazonaws.com/s3.cleverelephant.ca/postgis-workshop-2020.zip"

echo "==> Extracting..."
unzip -q "$TMP_DIR/nyc_data.zip" -d "$TMP_DIR"

# Find the SQL file (location varies by archive version)
SQL_FILE=$(find "$TMP_DIR" -name "nyc_data.backup" -o -name "*.sql" | head -1)

if [ -z "$SQL_FILE" ]; then
  echo "ERROR: Could not find SQL/backup file in archive."
  ls "$TMP_DIR"
  exit 1
fi

echo "==> Creating database..."
docker exec "$CONTAINER" psql -U "$USER" -c "DROP DATABASE IF EXISTS $DB;" 2>/dev/null || true
docker exec "$CONTAINER" psql -U "$USER" -c "CREATE DATABASE $DB;"
docker exec "$CONTAINER" psql -U "$USER" -d "$DB" -c "CREATE EXTENSION IF NOT EXISTS postgis;"

echo "==> Loading data..."
# Copy the file into the container and restore
docker cp "$SQL_FILE" "$CONTAINER:/tmp/nyc_data"
docker exec "$CONTAINER" pg_restore -U "$USER" -d "$DB" /tmp/nyc_data 2>/dev/null || \
docker exec "$CONTAINER" psql -U "$USER" -d "$DB" -f /tmp/nyc_data

echo "==> Verifying..."
docker exec "$CONTAINER" psql -U "$USER" -d "$DB" -c "\dt"

echo "==> Done. Connect with: docker exec -it $CONTAINER psql -U $USER -d $DB"

rm -rf "$TMP_DIR"

# PostGIS Workshop Environment Setup

These notes walk through getting the PostGIS NYC workshop environment running inside Docker.

## Prerequisites

- Docker Desktop installed and running (see `docker-installation.md`)
- At least 4 GB free disk space for the PostGIS image and NYC data

---

## Step 1 — Pull the PostGIS Image

```bash
docker pull postgis/postgis
```

This downloads the official PostGIS image (~400 MB). Only needed once.

---

## Step 2 — Create a Data Directory

Choose a location on your machine to persist the database:

**Windows (PowerShell):**
```powershell
$DATA_DIR = "C:\gist415\postgres_data"
New-Item -ItemType Directory -Force $DATA_DIR
```

**Mac/Linux:**
```bash
DATA_DIR=~/gist415/postgres_data
mkdir -p $DATA_DIR
```

---

## Step 3 — Run the PostGIS Container

**Windows (PowerShell):**
```powershell
docker run -d --name postgis `
  -e POSTGRES_PASSWORD=postgres `
  -v "${DATA_DIR}:/var/lib/postgresql/data" `
  -p 25432:5432 `
  postgis/postgis
```

**Mac/Linux:**
```bash
docker run -d --name postgis \
  -e POSTGRES_PASSWORD=postgres \
  -v "$DATA_DIR:/var/lib/postgresql/data" \
  -p 25432:5432 \
  postgis/postgis
```

Wait ~10 seconds for PostgreSQL to initialize, then verify:
```bash
docker ps
```

---

## Step 4 — Create the NYC Database

```bash
docker exec -it postgis psql -U postgres -c "CREATE DATABASE nyc;"
docker exec -it postgis psql -U postgres -d nyc -c "CREATE EXTENSION postgis;"
```

---

## Step 5 — Load the NYC Workshop Data

Run the populate script (requires the container to be named `postgis`):

```bash
bash scripts/populate_nyc.sh
```

This downloads the NYC workshop dataset and loads it into the `nyc` database. May take 2–5 minutes.

---

## Step 6 — Verify the Data

Connect to the database:
```bash
docker exec -it postgis psql -U postgres -d nyc
```

List tables:
```sql
\dt
```

You should see: `nyc_census_blocks`, `nyc_homicides`, `nyc_neighborhoods`, `nyc_streets`, `nyc_subway_stations`.

---

## Connecting with QGIS

1. Open QGIS → Layer → Add Layer → Add PostGIS Layers
2. New Connection:
   - Host: `localhost`
   - Port: `25432`
   - Database: `nyc`
   - Username: `postgres`
   - Password: `postgres`
3. Click Test Connection → OK

---

## Connecting with pgAdmin / DBeaver

Use the same credentials:
- Host: `localhost`
- Port: `25432`
- Database: `nyc`
- Username: `postgres`
- Password: `postgres`

---

## Stopping and Restarting

```bash
# Stop
docker stop postgis

# Start again (data persists in the volume)
docker start postgis
```

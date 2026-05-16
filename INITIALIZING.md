# Prerequisites — Unit 7 Initialization

Unit 7 builds on the Docker environment from Unit 6. If your Unit 6 PostGIS container is still running, you can reuse it. If not, follow these steps.

---

## Check Existing Containers

```bash
docker ps -a
```

Look for containers named `postgis` and `geoserver`.

- **Running** (`Up ...`) — you're good, skip to the relevant assignment.
- **Stopped** (`Exited`) — restart them: `docker start postgis geoserver`
- **Missing** — follow the setup steps below.

---

## Option A — Use docker compose (Assignment 1)

If you haven't done Assignment 1 yet, start there. Edit `assignment-1/docker-compose.yml` with your local paths, then:

```bash
cd assignment-1
docker compose up -d
```

This starts both PostGIS and GeoServer together.

---

## Option B — Start containers manually

```bash
# Start PostGIS (replace path with your data directory from Unit 6)
docker run -d --name postgis \
  -e POSTGRES_PASSWORD=postgres \
  -v /your/path/postgres_data:/var/lib/postgresql/data \
  -p 25432:5432 \
  --network gist415 \
  postgis/postgis:15-3.3

# Start GeoServer
docker run -d --name geoserver \
  -e GEOSERVER_ADMIN_PASSWORD=geoserver \
  -e GEOSERVER_ADMIN_USER=admin \
  -v /your/path/geoserver_data:/opt/geoserver/data_dir \
  -p 8080:8080 \
  --network gist415 \
  kartoza/geoserver:2.23.0
```

Create the network first if it doesn't exist:
```bash
docker network create gist415
```

---

## Verify Services

| Service | URL | Credentials |
|---|---|---|
| GeoServer | http://localhost:8080/geoserver/web | admin / geoserver |
| PostGIS | localhost:25432 | postgres / postgres |

GeoServer can take 1–2 minutes to fully start. Refresh if you get a connection error.

---

## OSM Data Not Loaded?

If the Arizona OSM data from Assignment 3 is missing, re-run:

```bash
bash populate.sh
```

# Prerequisites — Unit 6 Initialization

Unit 6 builds on the Docker environment from Unit 5. If your Unit 5 PostGIS container is still running, you can reuse it. If not, follow these steps.

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
# Start PostGIS (use your postgres_data folder from Unit 5)
docker run -d --name postgis -e POSTGRES_PASSWORD=postgres -v c:/gist415_data/postgres_data:/var/lib/postgresql -p 25432:5432 --network gist415 postgis/postgis:18-3.6-alpine

# Start GeoServer
docker run -d --name geoserver -e GEOSERVER_ADMIN_PASSWORD=geoserver -e GEOSERVER_ADMIN_USER=admin -v c:/gist415_data/geoserver_data:/opt/geoserver/data_dir -p 8280:8080 --network gist415 kartoza/geoserver:2.23.0
```

Each command is one line, so it works the same in PowerShell and in the Mac Terminal. On a Mac, change `c:/gist415_data` to your folder, e.g. `/Users/yourname/gist415_data`. Never change the part after the colon.

Create the network first if it doesn't exist:
```bash
docker network create gist415
```

---

## Verify Services

| Service | URL | Credentials |
|---|---|---|
| GeoServer | http://localhost:8280/geoserver/web | admin / geoserver |
| PostGIS | localhost:25432 | postgres / postgres |

GeoServer can take 1–2 minutes to fully start. Refresh if you get a connection error.

---

## OSM Data Not Loaded?

If the Arizona OSM data from Assignment 3 is missing, re-run the Assignment 3 loader (one line; works in PowerShell and the Mac Terminal):

```bash
docker run --rm --network gist415 -e STATE=arizona -e DATABASE=arizona aaryno/populate-docker-geo populate-postgis.sh
```

On a Mac you can run `bash populate.sh` instead, which runs the same command.

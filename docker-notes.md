# Docker Quick Reference — Unit 7

## Common Commands

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Start / stop a container
docker start <name>
docker stop <name>

# View logs
docker logs <name>
docker logs -f <name>   # follow (live)

# Open a shell inside a container
docker exec -it <name> bash

# Connect to PostGIS with psql
docker exec -it postgis psql -U postgres -d gis
```

---

## Docker Compose Commands

Run these from the folder containing `docker-compose.yml`:

```bash
# Start all services (detached)
docker compose up -d

# Stop all services
docker compose down

# Stop and remove volumes (WARNING: deletes data)
docker compose down -v

# View logs for all services
docker compose logs -f

# Rebuild images
docker compose build
```

---

## Networking

Containers on the same Docker network can reach each other by **container name** (not `localhost`).

```bash
# Create the shared network
docker network create gist415

# Inspect the network
docker network inspect gist415
```

PostGIS host from inside GeoServer: `postgis` (the container name), port `5432` (internal port, not 25432).

---

## Volumes

```bash
# List volumes
docker volume ls

# Inspect a volume (shows mount path)
docker volume inspect <volume-name>

# Remove an unused volume
docker volume rm <volume-name>
```

---

## Images

```bash
# List downloaded images
docker images

# Pull an image
docker pull postgis/postgis:15-3.3
docker pull kartoza/geoserver:2.23.0

# Remove an image
docker rmi <image-id>
```

---

## Port Reference

| Container | Internal Port | External Port | URL |
|---|---|---|---|
| postgis | 5432 | 25432 | — |
| geoserver | 8080 | 8080 | http://localhost:8080/geoserver/web |
| nginx (A4) | 80 | 8888 | http://localhost:8888 |

---

## GeoServer Credentials

Default: **admin / geoserver**

Change in GeoServer → Security → Users/Groups if needed.

# GIST 415 — Unit 7: GeoServer & Web Maps

This is your **Unit 7 repository**. All Unit 7 assignments are submitted here — each on its own branch inside its own subfolder.

## Provided Starter Files

| File | Purpose |
|---|---|
| `getting-started.html` | Leaflet starter map centered on Hawaii (A4 — you will customize it) |
| `INITIALIZING.md` | Prerequisites help if your Unit 6 environment isn't running |
| `docker-notes.md` | Docker quick-reference for this unit |
| `Dockerfile` | Container reference |
| `populate.sh` | Helper script for OSM data import |
| `assignment-1/docker-compose.yml` | Starting Compose config — edit volume paths for your machine |
| `assignment-4/Dockerfile` | nginx Dockerfile for the Leaflet container — you will modify this |

## Assignment Submission Map

| Assignment | Branch | Deliverables |
|---|---|---|
| A1: Docker Compose — PostGIS + GeoServer | `assignment-1` | `assignment-1/docker-compose.yml`, `assignment-1/compose_screenshot.png` |
| A2: GeoServer Introduction | `assignment-2` | `assignment-2/answers.md`, `assignment-2/screencap-archsites.png`, `assignment-2/screencap-layergroup.png` |
| A3: PostGIS, OSM & GeoServer | `assignment-3` | `assignment-3/landuse.sld`, `assignment-3/roads.sld`, `assignment-3/pois.sld`, `assignment-3/geoserver_layer_group_preview.png`, `assignment-3/qgis_layer_group_preview.png` |
| A4: Leaflet Web Map | `assignment-4` | `assignment-4/screenshot-getting-started.png`, `assignment-4/geoserver.html`, `assignment-4/docker-compose.yml`, `assignment-4/Dockerfile`, `assignment-4/docker-compose-geoserver-screenshot.png` |

## How to Submit Each Assignment

1. Create the branch (e.g., `assignment-1`) from `main`
2. Place all your files inside the matching subfolder (e.g., `assignment-1/`)
3. Commit and push to GitHub
4. Open a Pull Request from your branch → `main`
5. The automated checker will comment ✅/❌ on required files — fix anything flagged ❌
6. Submit the Pull Request URL in the D2L submission folder

## Prerequisites

All Unit 7 assignments build on each other. Start in order:

1. **A1** — Get PostGIS + GeoServer running via Docker Compose
2. **A2** — Explore GeoServer with the sample data it ships with
3. **A3** — Import Arizona OSM data and build a full styled layer group
4. **A4** — Build the Leaflet web map on top of the full stack

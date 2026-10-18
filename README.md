# GIST 415 — Unit 6: GeoServer & Web Maps

This is your **Unit 6 repository**. You create it once, in Assignment 1, and use it for all 4 Unit 6 assignments. Do not create another repository for this unit.

Written answers go in [`SUBMISSION.md`](SUBMISSION.md). Screenshots and other files go in each assignment's `assignment-N/` folder.

## Setting Up This Repository (Assignment 1)

1. On the template page, click **Use this template** → **Create a new repository**
2. Set **Owner** to the class GitHub organization (the name is in the D2L course announcement), not your personal account
3. Name it exactly `gist415-unit-6-YOUR_NETID` (for example `gist415-unit-6-jsmith`)
4. Set visibility to **Private**
5. Click **Create repository**, then clone it with GitHub Desktop (**File → Clone Repository**)
6. In GitHub Desktop, create a branch named `unit-6-work` (**Current Branch → New Branch**) and click **Publish branch**

## Assignments

| Assignment | What you submit | Points |
|---|---|---|
| A1: Docker Compose — PostGIS + GeoServer | `assignment-1/docker-compose.yml`, `assignment-1/compose_screenshot.png` | 20 |
| A2: Introduction to GeoServer | `SUBMISSION.md` section, `assignment-2/screencap-archsites.png`, `assignment-2/screencap-layergroup.png` | 20 |
| A3: PostGIS, OSM & GeoServer | `assignment-3/landuse.sld`, `assignment-3/roads.sld`, `assignment-3/pois.sld`, `assignment-3/geoserver_layer_group_preview.png`, `assignment-3/qgis_layer_group_preview.png` | 20 |
| A4: Web Mapping with Leaflet | `assignment-4/screenshot-getting-started.png`, `assignment-4/geoserver.html`, `assignment-4/docker-compose.yml`, `assignment-4/Dockerfile`, `assignment-4/docker-compose-geoserver-screenshot.png` | 40 |
| **Unit 6 total** | | **100** |

Full instructions for each assignment are in D2L.

## How to Submit

You work on **one branch** and open **one Pull Request** for the whole unit.

1. Commit all Unit 6 work to your `unit-6-work` branch
2. In Assignment 1, open a Pull Request from `unit-6-work` → `main`, titled `Unit 6 Submission — YOUR_NETID`
3. For each later assignment, commit and push to the same branch; the same Pull Request updates automatically
4. After Assignment 4, check that every row of the checker's comment shows ✅, then submit the Pull Request URL in the D2L Unit 6 submission folder

**Do not merge the Pull Request.** Leave it open for instructor review.

## Provided Starter Files

| File | Purpose |
|---|---|
| `getting-started.html` | Leaflet starter map centered on Hawaii (A4 — you will customize it) |
| `INITIALIZING.md` | Prerequisites help if your Unit 5 environment isn't running |
| `docker-notes.md` | Docker quick-reference for this unit |
| `Dockerfile` | Container reference |
| `populate.sh` | Helper script for OSM data import |
| `assignment-1/docker-compose.yml` | Starting Compose config — edit volume paths for your machine |
| `assignment-4/Dockerfile` | nginx Dockerfile for the Leaflet container — you will modify this |

## Prerequisites

All Unit 6 assignments build on each other. Start in order:

1. **A1** — Get PostGIS + GeoServer running via Docker Compose
2. **A2** — Explore GeoServer with the sample data it ships with
3. **A3** — Import Arizona OSM data and build a full styled layer group
4. **A4** — Build the Leaflet web map on top of the full stack

## Automated Checker

When you open or update your Pull Request, a GitHub Action posts a comment listing, for each assignment, whether its `SUBMISSION.md` section is answered and its required files are present. Assignments you have not reached yet show ❌ until you complete them.

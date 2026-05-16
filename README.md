# GIST 415 — Unit 6: Docker & PostGIS

This is your **Unit 6 repository**. All Unit 6 assignments are submitted here — each on its own branch inside its own subfolder.

## Provided Reference Files

| File | Purpose |
|---|---|
| `docker-installation.md` | Docker Desktop installation help for Windows and Mac |
| `CHEAT.md` | PostGIS SQL quick-reference cheat sheet |
| `installing.md` | PostGIS workshop environment setup notes |
| `Dockerfile` | Container reference used in the workshop |
| `scripts/populate_nyc.sh` | Helper script — imports NYC workshop data into PostGIS |

## Assignment Submission Map

| Assignment | Branch | Deliverables |
|---|---|---|
| A1: Docker Introduction | `assignment-1` | `assignment-1/answers.txt`, `assignment-1/screencap-volume-inspect.png` |
| A2: PostGIS Docker Setup | `assignment-2` | `assignment-2/data_dir.png`, `assignment-2/screenshot_connection.png`, `assignment-2/screenshot_table.png` |
| A3: PostGIS Introduction | `assignment-3` | `assignment-3/answers.md` |

## How to Submit Each Assignment

1. Create the branch (e.g., `assignment-1`) from `main`
2. Place all your files inside the matching subfolder (e.g., `assignment-1/`)
3. Commit and push to GitHub
4. Open a Pull Request from your branch → `main`
5. The automated checker will comment ✅/❌ on required files — fix anything flagged ❌
6. Submit the Pull Request URL in the D2L submission folder

## Quick Docker Reference

```bash
# Pull PostGIS image
docker pull postgis/postgis

# Run with persistent volume (replace $DATA_DIR with your path)
docker run -d --name postgis \
  -e POSTGRES_PASSWORD=postgres \
  -v $DATA_DIR/postgres_data/data:/var/lib/postgresql/data \
  -p 25432:5432 \
  postgis/postgis

# Create shared network
docker network create gist415
```

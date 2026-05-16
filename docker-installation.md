# Docker Desktop Installation

## Windows

1. Download Docker Desktop from [docs.docker.com/desktop/install/windows-install](https://docs.docker.com/desktop/install/windows-install/)
2. Run the installer — it will install WSL 2 if not already present
3. Restart your machine when prompted
4. Launch Docker Desktop and wait for the engine to start (whale icon in system tray turns solid)
5. Verify in PowerShell: `docker --version`

### WSL 2 Requirement

Docker Desktop on Windows requires WSL 2. If the installer fails:

```powershell
wsl --install
wsl --set-default-version 2
```

Then re-run the Docker Desktop installer.

### Common Issues

- **"Hardware assisted virtualization and data execution protection must be enabled"** — enable virtualization in BIOS/UEFI (usually under CPU or Advanced settings)
- **Docker Desktop stuck starting** — open Task Manager → restart "Docker Desktop Service"
- **`docker: command not found` in PowerShell** — restart your terminal after installation

---

## Mac

1. Download Docker Desktop from [docs.docker.com/desktop/install/mac-install](https://docs.docker.com/desktop/install/mac-install/)
2. Choose the correct chip: **Apple Silicon (M1/M2/M3)** or **Intel**
3. Open the `.dmg` and drag Docker to Applications
4. Launch Docker from Applications and accept the service agreement
5. Wait for the whale icon in the menu bar to stop animating
6. Verify in Terminal: `docker --version`

### Common Issues

- **Rosetta warning on Apple Silicon** — install Rosetta: `softwareupdate --install-rosetta`
- **Slow first pull** — normal; images are cached after the first download

---

## Verify Your Installation

Run both commands and confirm output:

```bash
docker --version
# Docker version 24.x.x, build ...

docker compose version
# Docker Compose version v2.x.x
```

If `docker compose` fails but `docker-compose` works, you have Compose v1 — update Docker Desktop.

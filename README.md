![Debian](https://img.shields.io/badge/Debian-12-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Server-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Tailscale](https://img.shields.io/badge/Tailscale-VPN-242424?style=for-the-badge&logo=tailscale&logoColor=white)
![AdGuard](https://img.shields.io/badge/AdGuard-DNS-68BC71?style=for-the-badge&logo=adguard&logoColor=white)
![Jellyfin](https://img.shields.io/badge/Jellyfin-Media-00A4DC?style=for-the-badge&logo=jellyfin&logoColor=white)
![Nextcloud](https://img.shields.io/badge/Nextcloud-Storage-0082C9?style=for-the-badge&logo=nextcloud&logoColor=white)
![GitHub](https://img.shields.io/badge/Self--Hosted-Project-181717?style=for-the-badge&logo=github&logoColor=white)
# Home Server Setup

A self-hosted home server running on a 2017 Acer laptop with Debian 12 and Docker.

## Hardware
- 2017 Acer Laptop
- 1TB Storage
- Connected via WiFi

## Network Diagram

<img width="1111" height="768" alt="Network Diagram (1)" src="https://github.com/user-attachments/assets/90225f34-f55a-4ed9-b636-e658c29e80b5" />

## Dashboard

<img width="1919" height="1041" alt="image" src="https://github.com/user-attachments/assets/3b24f60d-8198-482f-bf7a-80871999facb" />


## Stack Overview

### Media
- **Navidrome** - Music streaming server with Subsonic API support
- **Jellyfin** - Movies and TV shows media server
- **Radarr** - Automatic movie downloading and management
- **Sonarr** - Automatic TV show downloading and management
- **Prowlarr** - Indexer manager for Radarr and Sonarr
- **Jackett** - Additional indexer support for public trackers
- **qBittorrent** - Torrent download client
- **Bazarr** - Automatic subtitle downloading for Jellyfin

### Storage & Files
- **Nextcloud** - Self hosted cloud storage with cross device sync
- **Filebrowser** - Web based file manager

### Network & Privacy
- **AdGuard Home** - Network wide ad blocking and DNS privacy with DNS-over-HTTPS
- **Tailscale** - Secure remote access VPN to all services from anywhere

### Monitoring & Management
- **Portainer** - Docker container management dashboard
- **Uptime Kuma** - Service uptime monitoring and alerting
- **Watchtower** - Automatic Docker container updates
- **Netdata** - Real time system performance monitoring
- **Homarr** - Unified dashboard for all services

## Architecture
All services run as Docker containers managed with Docker Compose. Each service has its own stack folder under `/opt/stacks/`.

## Remote Access
Remote access is handled via Tailscale VPN. AdGuard Home is configured as the DNS server for all Tailscale devices, providing ad blocking and DNS privacy everywhere.

## Media Management
Movies and TV shows are automatically downloaded using the arr stack:
1. Add movie/show to Radarr/Sonarr
2. Prowlarr and Jackett search indexers for the best release
3. qBittorrent downloads the file
4. Radarr/Sonarr moves it to the correct media folder
5. Jellyfin picks it up automatically
6. Bazarr downloads English subtitles automatically

## Services & Ports
| Service | Port |
|---|---|
| Navidrome | 4533 |
| Jellyfin | 8096 |
| Nextcloud | 8080 |
| AdGuard Home | 8889 |
| Portainer | 9000 |
| Uptime Kuma | 3001 |
| Netdata | 19999 |
| Homarr | 7575 |
| qBittorrent | 8090 |
| Radarr | 7878 |
| Sonarr | 8989 |
| Prowlarr | 9696 |
| Jackett | 9117 |
| Bazarr | 6767 |
| Filebrowser | 8082 |

## Scripts

- `scripts/backup.sh` — backs up all Docker volumes and compose files, keeps 7 days of history
- `scripts/sync-music.sh` — syncs your local music library to the server via rsync

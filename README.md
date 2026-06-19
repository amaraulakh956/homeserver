![Debian](https://img.shields.io/badge/Debian-12-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Server-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Headscale](https://img.shields.io/badge/Headscale-VPN-242424?style=for-the-badge&logo=tailscale&logoColor=white)
![AdGuard](https://img.shields.io/badge/AdGuard-DNS-68BC71?style=for-the-badge&logo=adguard&logoColor=white)
![Jellyfin](https://img.shields.io/badge/Jellyfin-Media-00A4DC?style=for-the-badge&logo=jellyfin&logoColor=white)
![Nextcloud](https://img.shields.io/badge/Nextcloud-Storage-0082C9?style=for-the-badge&logo=nextcloud&logoColor=white)
![GitHub](https://img.shields.io/badge/Self--Hosted-Project-181717?style=for-the-badge&logo=github&logoColor=white)

# Home Server Setup

A self-hosted home server running on a 2017 Acer laptop with Debian 12 and Docker.

## Hardware
- 2017 Acer Laptop
- 1TB Storage
- Connected via Ethernet

## Network Diagram

![Network Diagram](diagram.png)

## Dashboard

![Homarr Dashboard](homarr.png)

## Stack Overview

> For a detailed breakdown of each service and why it was chosen, see [SERVICES.md](SERVICES.md).

### Media
- **Navidrome** - Music streaming server with Subsonic API support
- **Jellyfin** - Movies and TV shows media server with Intel QSV hardware transcoding
- **Jellyseerr** - Request interface for movies and shows, integrates with Radarr and Sonarr
- **Radarr** - Automatic movie downloading and management
- **Sonarr** - Automatic TV show and anime downloading and management
- **Prowlarr** - Indexer manager for Radarr and Sonarr
- **Jackett** - Additional indexer support for public trackers (YTS, 1337x, Nyaa.si, Pirate Bay)
- **qBittorrent** - Torrent download client
- **Bazarr** - Automatic subtitle downloading for Jellyfin
- **Tdarr** - Automated media transcoding to save disk space
- **FlareSolverr** - Cloudflare bypass for Jackett indexers

### Storage & Files
- **Nextcloud** - Self hosted cloud storage with cross device sync
- **Filebrowser** - Web based file manager

### Network & Privacy
- **AdGuard Home** - Network wide ad blocking and DNS privacy with DNS-over-HTTPS
- **Headscale** - Self-hosted WireGuard coordination server replacing Tailscale
- **Caddy** - Reverse proxy with automatic HTTPS via Let's Encrypt

### Productivity
- **Vaultwarden** - Self hosted Bitwarden password manager
- **SearXNG** - Self hosted private search engine

### Monitoring & Management
- **Portainer** - Docker container management dashboard
- **Uptime Kuma** - Service uptime monitoring and alerting
- **Watchtower** - Automatic Docker container updates
- **Homarr** - Unified dashboard for all services

## Architecture
All services run as Docker containers managed with Docker Compose. Each service has its own stack folder under `/opt/stacks/`. Caddy handles reverse proxy and HTTPS for all services using a Let's Encrypt certificate issued for the DuckDNS domain.

## Remote Access
Remote access is handled via **Headscale** — a self-hosted open source replacement for Tailscale's coordination server. All devices connect via WireGuard encrypted tunnels. AdGuard Home is configured as the DNS server for all connected devices, providing ad blocking and DNS-over-HTTPS privacy everywhere.

A DuckDNS domain with auto-renewing Let's Encrypt certificates provides trusted HTTPS for Headscale and all services.

## Media Management
Movies and TV shows are automatically downloaded using the arr stack:
1. Request content in Jellyseerr
2. Jellyseerr sends the request to Radarr or Sonarr
3. Prowlarr and Jackett search indexers for the best release
4. qBittorrent downloads the file
5. Radarr/Sonarr moves it to the correct media folder
6. Jellyfin picks it up automatically
7. Bazarr downloads English subtitles automatically

## Services & Ports
| Service | Port |
|---|---|
| Navidrome | 4533 |
| Jellyfin | 8096 |
| Jellyseerr | 5055 |
| Nextcloud | 8080 |
| AdGuard Home | 8889 |
| Portainer | 9000 |
| Uptime Kuma | 3001 |
| Homarr | 7575 |
| qBittorrent | 8090 |
| Radarr | 7878 |
| Sonarr | 8989 |
| Prowlarr | 9696 |
| Jackett | 9117 |
| Bazarr | 6767 |
| Filebrowser | 8082 |
| SearXNG | 8099 |
| Vaultwarden | 8181 |
| Tdarr | 8265 |
| Headscale | 443 |

## Scripts

- `scripts/backup.sh` — backs up all Docker volumes and compose files, keeps 7 days of history
- `scripts/sync-music.sh` — syncs your local music library to the server via rsync

## License

MIT — see [LICENSE](LICENSE) for details.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

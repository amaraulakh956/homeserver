# Home Server Setup

A self-hosted home server running on a 2017 Acer laptop with Debian 12 and Docker.

## Hardware
- 2017 Acer Laptop
- 1TB Storage
- Connected via WiFi

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

# Services

A detailed breakdown of every service running on this server, why it was chosen, and how it fits into the stack.

## Media

### Jellyfin
Self-hosted media server for movies and TV shows. Chosen over Plex because it is completely free with no subscription required, requires no account, and keeps all data local. Supports hardware transcoding via Intel Quick Sync for efficient streaming.

### Navidrome
Music streaming server with Subsonic API support. Chosen over Jellyfin for music because it is purpose built for audio, significantly lighter on resources, and supports excellent mobile apps like Symfonium and Substreamer for on-the-go streaming.

### Bazarr
Automatic subtitle downloader that integrates with Radarr and Sonarr. Monitors your media library and automatically fetches subtitles from OpenSubtitles, removing the need to manually find and add subtitle files.

### Nextcloud
Self-hosted cloud storage and file sync. Replaces Google Drive for storing and syncing personal files across devices. The desktop and mobile clients keep everything in sync automatically.

## Automation Pipeline

### Radarr
Automated movie library manager. Monitors for new releases, searches indexers for the best quality version, sends downloads to qBittorrent, and organises completed files into the Jellyfin media folder automatically.

### Sonarr
Same as Radarr but for TV shows and anime. Monitors entire series, downloads new episodes automatically as they release, and keeps the library organised.

### Prowlarr
Centralised indexer manager for Radarr and Sonarr. Manages all torrent indexers in one place and syncs them to both apps automatically, removing the need to configure indexers in each app separately.

### Jackett
Supplementary indexer proxy that adds support for public trackers like YTS, 1337x, The Pirate Bay, and Nyaa.si that are not available natively in Prowlarr. Integrated with FlareSolverr to bypass Cloudflare protection on some indexers.

### qBittorrent
Torrent download client. Receives download requests from Radarr and Sonarr, downloads files to a staging folder, and notifies the arr apps when complete so they can move files to the correct media folder.

### FlareSolverr
Proxy server that helps Jackett and Prowlarr bypass Cloudflare protection on certain torrent indexers. Runs as a background service with no UI.

## Network & Privacy

### AdGuard Home
Network-wide DNS server and ad blocker. Chosen over Pi-hole for better Tailscale integration, built-in DNS-over-HTTPS support, and faster performance. All Tailscale-connected devices route DNS through AdGuard Home, providing ad blocking and privacy everywhere.

### Tailscale
Encrypted mesh VPN that connects all personal devices to the home server securely from anywhere. Chosen over WireGuard because it requires zero port forwarding, works behind NAT, and is significantly easier to manage. AdGuard Home is configured as the DNS server for all Tailscale devices.

## Storage & Files

### Filebrowser
Web-based file manager providing a GUI for browsing, uploading, downloading, and managing all media files on the server without needing SSH or command line access.

## Monitoring & Management

### Portainer
Docker container management dashboard. Provides a visual interface for managing all containers, viewing logs, and monitoring resource usage without needing to use the command line.

### Uptime Kuma
Self-hosted uptime monitoring tool. Monitors all services and sends alerts if anything goes down. Provides a clean status dashboard showing uptime history for each service.

### Netdata
Real-time system performance monitoring. Tracks CPU, RAM, disk, network usage, and hardware temperatures. Useful for identifying resource bottlenecks and monitoring server health.

### Watchtower
Automatically updates all Docker containers when new images are released. Runs daily at 4am and cleans up old images after updating to save disk space. Ensures all services stay up to date without manual intervention.

### Homarr
Unified dashboard for all services. Provides a single page with links and icons for every service, replacing the need to remember individual port numbers.

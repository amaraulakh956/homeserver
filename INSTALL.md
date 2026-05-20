# Installation Guide

A complete guide to recreating this home server setup from scratch.

## Prerequisites

- A laptop or PC with at least 4GB RAM and 500GB storage
- A USB drive (8GB+)
- A Tailscale account (free) — [tailscale.com](https://tailscale.com)
- An OpenSubtitles account (free) — [opensubtitles.com](https://www.opensubtitles.com)

---

## 1. Install Debian 12

Download the Debian 12 netinstall ISO from [debian.org](https://www.debian.org/distrib/netinst) and flash it to a USB drive using [Balena Etcher](https://etcher.balena.io/) or [Rufus](https://rufus.ie/).

During installation:
- Set hostname to `homeserver`
- Create a user account
- When prompted for software selection, select only:
  - `SSH server`
  - `standard system utilities`
- Use guided partitioning with the entire disk

After booting, install sudo and add your user:

```bash
su -
apt install sudo -y
usermod -aG sudo yourusername
exit
```

---

## 2. Install Docker

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl -y
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
```

Log out and back in, then verify:

```bash
docker run hello-world
```

---

## 3. Set Up Folder Structure

```bash
sudo mkdir -p /opt/stacks
sudo mkdir -p /opt/media/music
sudo mkdir -p /opt/media/movies
sudo mkdir -p /opt/media/shows
sudo mkdir -p /opt/media/downloads/complete
sudo mkdir -p /opt/media/downloads/incomplete
sudo chown -R $USER:$USER /opt/stacks
sudo chown -R $USER:$USER /opt/media
```

---

## 4. Configure Lid Behaviour

Keep the server running with the lid closed:

```bash
sudo nano /etc/systemd/logind.conf
```

Change:
```
HandleLidSwitch=ignore
```

Apply:
```bash
sudo systemctl restart systemd-logind
```

---

## 5. Install Tailscale

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

Authenticate via the URL provided, then enable exit node advertising:

```bash
sudo tailscale up --advertise-exit-node
```

Approve the exit node in your Tailscale admin dashboard.

---

## 6. Deploy Services

Each service lives in its own folder under `/opt/stacks/`. Clone this repo and copy the compose files:

```bash
sudo apt install git -y
git clone https://github.com/amaraulakh956/homeserver.git
cd homeserver
cp -r stacks/* /opt/stacks/
```

Start all services:

```bash
for dir in /opt/stacks/*/; do
  cd "$dir" && docker compose up -d && cd -
done
```

---

## 7. Configure AdGuard Home

1. Open `http://your-server-ip:3000` and complete the setup wizard
2. Set upstream DNS to:
   ```
   https://dns.cloudflare.com/dns-query
   https://dns.google/dns-query
   ```
3. Set bootstrap DNS to `1.1.1.1` and `8.8.8.8`
4. In Tailscale admin → DNS → add your server's Tailscale IP as a global nameserver
5. Enable **Override local DNS**

---

## 8. Configure the Arr Stack

### qBittorrent
1. Open `http://your-server-ip:8090`
2. Go to **Tools → Options → Downloads**
3. Set save path to `/downloads/complete`
4. Set incomplete path to `/downloads/incomplete`

### Jackett
1. Open `http://your-server-ip:9117`
2. Add indexers: YTS, 1337x, The Pirate Bay, EZTV, Nyaa.si
3. Set FlareSolverr URL to `http://your-server-ip:8191`

### Prowlarr
1. Open `http://your-server-ip:9696`
2. Go to **Settings → Apps** and add Radarr and Sonarr with their API keys
3. Add Jackett indexers as Generic Torznab indexers

### Radarr
1. Open `http://your-server-ip:7878`
2. Go to **Settings → Download Clients** and add qBittorrent
3. Go to **Settings → Media Management** and add root folder `/movies`

### Sonarr
1. Open `http://your-server-ip:8989`
2. Go to **Settings → Download Clients** and add qBittorrent
3. Go to **Settings → Media Management** and add root folder `/tv`

### Bazarr
1. Open `http://your-server-ip:6767`
2. Connect to Radarr and Sonarr with their API keys
3. Add OpenSubtitles as a provider
4. Create an English language profile and assign it to all media

---

## 9. Add Music

Sync your music library to the server using rsync:

```bash
rsync -av --progress /path/to/music/ user@your-server-ip:/opt/media/music/
```

Then trigger a scan in Navidrome at `http://your-server-ip:4533`.

---

## 10. Access Your Services

| Service | URL |
|---|---|
| Homarr (dashboard) | `http://your-server-ip:7575` |
| Navidrome | `http://your-server-ip:4533` |
| Jellyfin | `http://your-server-ip:8096` |
| Nextcloud | `http://your-server-ip:8080` |
| AdGuard Home | `http://your-server-ip:8889` |
| Portainer | `http://your-server-ip:9000` |
| Uptime Kuma | `http://your-server-ip:3001` |
| Netdata | `http://your-server-ip:19999` |
| qBittorrent | `http://your-server-ip:8090` |
| Radarr | `http://your-server-ip:7878` |
| Sonarr | `http://your-server-ip:8989` |
| Prowlarr | `http://your-server-ip:9696` |
| Jackett | `http://your-server-ip:9117` |
| Bazarr | `http://your-server-ip:6767` |
| Filebrowser | `http://your-server-ip:8082` |

For remote access, replace `your-server-ip` with your server's Tailscale IP.

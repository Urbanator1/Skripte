#!/bin/bash

# Skript für das Setzen von Repositories in Proxmox

echo "Entfernen vorhandener Repositories..."
rm -f /etc/apt/sources.list.d/*

echo "Konfiguration der /etc/apt/sources.list..."
cat <<EOL > /etc/apt/sources.list
# deb http://mirror.hetzner.com/debian/packages bookworm main contrib non-free

# deb http://mirror.hetzner.com/debian/packages bookworm-updates main contrib non-free

# deb http://mirror.hetzner.com/debian/packages bookworm-backports main contrib non-free

deb http://deb.debian.org/debian bookworm main contrib non-free

# deb-src http://deb.debian.org/debian bookworm main contrib non-free

deb http://deb.debian.org/debian bookworm-updates main contrib non-free

# deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free

deb http://deb.debian.org/debian bookworm-backports main contrib non-free

# deb-src http://deb.debian.org/debian bookworm-backports main contrib non-free

deb http://security.debian.org/debian-security bookworm-security main contrib non-free

# deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free
EOL

echo "Konfiguration der /etc/apt/sources.list.d/proxmox.list..."
cat <<EOL > /etc/apt/sources.list.d/proxmox.list
# PVE packages provided by proxmox.com
# deb http://mirror.hetzner.com/debian/pve bookworm pve-no-subscription

deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
EOL

echo "Aktualisieren der Paketlisten..."
apt update

echo "Alle Schritte erfolgreich abgeschlossen!"

#!/bin/bash
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Execute sem sudo: ./scripts/install-android.sh"
  exit 1
fi

if ! grep -qi 'trixie' /etc/os-release; then
  echo "Este instalador foi preparado para Debian 13 (Trixie)."
  exit 1
fi

echo "Waydroid no Debian 13 é distribuído pelo repositório backports."
sudo install -d -m 0755 /etc/apt/sources.list.d
sudo tee /etc/apt/sources.list.d/trixie-backports.sources >/dev/null <<'EOF'
Types: deb
URIs: http://deb.debian.org/debian
Suites: trixie-backports
Components: main contrib non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF

sudo apt update
sudo apt install -y -t trixie-backports waydroid labwc

echo
echo "Waydroid instalado. Verifique o suporte Binder antes de inicializar:"
echo "  sudo modprobe binder_linux"
echo "  ls -la /dev/binderfs"
echo
echo "Se o módulo não existir, o kernel precisa de suporte Binder."
echo "Waydroid só funciona em sessão Wayland: saia do XFCE e escolha labwc"
echo "na tela de login. Depois execute:"
echo "  sudo waydroid init"
echo "  waydroid session start"
echo "  waydroid show-full-ui"

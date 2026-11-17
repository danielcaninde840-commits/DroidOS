#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

if [[ "$(dpkg --print-architecture 2>/dev/null || true)" != "amd64" ]]; then
  echo "ERRO: construa a ISO em Debian/Ubuntu AMD64 (x86_64)." >&2
  exit 1
fi

if [[ $EUID -eq 0 ]]; then
  echo "Não execute este script como root. Ele chamará sudo quando necessário." >&2
  exit 1
fi

if ! command -v lb >/dev/null 2>&1; then
  echo "Instalando dependências do live-build..."
  sudo apt update
  sudo apt install -y live-build debootstrap xorriso squashfs-tools \
    grub-pc-bin grub-efi-amd64-bin grub-efi-amd64-signed \
    mtools dosfstools
fi

chmod +x auto/config config/hooks/normal/*.hook.chroot scripts/*.sh
echo "Configurando DroidOS 1.0..."
lb clean --purge || true
lb config
echo "Iniciando construção. Pode levar bastante tempo e baixar vários GB..."
sudo lb build

echo
echo "Construção finalizada. Procure live-image-amd64.hybrid.iso nesta pasta."

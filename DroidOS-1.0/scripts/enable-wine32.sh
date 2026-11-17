#!/bin/bash
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Execute sem sudo: ./scripts/enable-wine32.sh"
  exit 1
fi

sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y wine32:i386 libwine:i386
echo "Suporte Wine 32-bit instalado. Inicialize com: wineboot -u"

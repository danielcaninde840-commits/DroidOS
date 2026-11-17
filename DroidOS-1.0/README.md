# DroidOS 1.0 — primeira base de construção

DroidOS é um projeto de sistema Live baseado em Debian 13 (Trixie), AMD64,
com XFCE leve, Wine e suporte opcional a Waydroid.

> Estado: **kit de construção inicial**, não uma ISO pronta nem uma distribuição
> testada. A ISO só será produzida quando `./build.sh` terminar sem erros em um
> ambiente Debian 13 AMD64 com internet e espaço livre suficiente.

## Hardware-alvo

- Intel Pentium B950 (x86_64)
- 4 GB RAM
- SSD/HD de 256 GB
- UEFI
- Pendrive de 32 GB para gravar a ISO

## Decisões técnicas importantes

- XFCE é a sessão principal, priorizando baixo consumo.
- Wine é incluído para executar aplicativos Windows compatíveis. Nem todo EXE
  funciona; programas que exigem drivers, DirectX moderno ou componentes
  proprietários podem falhar.
- Waydroid é instalado **depois da instalação do sistema**, por script. No
  Debian 13 ele está nos backports. O Waydroid precisa de uma sessão Wayland;
  XFCE normalmente inicia em X11. O pacote `labwc` é incluído como compositor
  Wayland leve. Para Android, encerre a sessão XFCE e entre na sessão labwc.
- O funcionamento do Waydroid depende do suporte Binder no kernel. O Pentium
  B950 também possui gráficos Intel antigos; aceleração gráfica e desempenho
  de apps Android podem ser limitados.
- Android e programas Windows pesados não devem ser usados simultaneamente
  com apenas 4 GB de RAM.

## Requisitos para construir

Recomendado: Debian 13 AMD64 instalado ou uma máquina virtual Debian 13 com
pelo menos 4 núcleos, 8 GB de RAM e 30 GB livres. O computador-alvo pode ser
mais fraco; a construção da ISO deve ser feita em outra máquina mais potente,
se possível.

## Construir

No terminal de um Debian 13 AMD64:

```bash
sudo apt update
sudo apt install -y live-build debootstrap xorriso squashfs-tools \
  grub-pc-bin grub-efi-amd64-bin grub-efi-amd64-signed \
  mtools dosfstools
```

Extraia o ZIP, entre na pasta `DroidOS-1.0` e execute:

```bash
chmod +x build.sh scripts/*.sh
./build.sh
```

A imagem, se a construção for concluída, ficará em `live-image-amd64.hybrid.iso`
na pasta do projeto.

## Testar antes de instalar

1. Teste primeiro em uma máquina virtual (QEMU/VirtualBox).
2. Depois grave a ISO em um pendrive com Rufus ou balenaEtcher.
3. Inicie pelo menu de boot UEFI e escolha a opção Live.
4. Teste Wi-Fi, áudio, vídeo, teclado, touchpad e suspensão.
5. Não instale no disco interno antes de fazer backup.

## Instalar Android (Waydroid) após instalar o DroidOS

Abra um terminal no sistema instalado e execute:

```bash
sudo ./scripts/install-android.sh
```

O script habilita Debian Trixie Backports e instala Waydroid. Leia
`docs/ANDROID.md` antes de inicializar o Android.

## Instalar suporte adicional a aplicativos Windows 32-bit

```bash
sudo ./scripts/enable-wine32.sh
```

Depois inicialize o ambiente Wine com:

```bash
wineboot -u
```

## Limitações desta primeira versão

- Não inclui instalador gráfico próprio.
- Não inclui loja de aplicativos personalizada.
- Não inclui imagem Android pré-baixada nem Google Play.
- A compatibilidade com hardware do Positivo ainda precisa ser testada.
- Não foi possível validar uma compilação ISO neste ambiente de criação dos
  arquivos. A geração depende de executar `build.sh` em Debian 13 AMD64.

# Android no DroidOS (Waydroid)

## Requisitos e avisos

Waydroid executa Android em contêiner Linux e requer sessão Wayland e suporte
Binder no kernel. A sessão padrão do DroidOS é XFCE/X11 para manter o desktop
simples. Para usar Android, faça logout e selecione `labwc` na tela de login.

No Pentium B950, a GPU Intel integrada é antiga. Pode haver falhas de aceleração,
desempenho baixo ou incompatibilidade de alguns aplicativos. 4 GB de RAM é
limitado; feche navegador e outros programas antes de abrir o Android.

## Instalação

```bash
sudo modprobe binder_linux
ls -la /dev/binderfs
sudo waydroid init
waydroid session start
waydroid show-full-ui
```

Se `modprobe binder_linux` retornar que o módulo não existe, não prossiga
assumindo que o Android funcionará: será necessário um kernel com Binder
habilitado. A disponibilidade exata depende do kernel e da configuração.

Waydroid não garante compatibilidade com todos os APKs, serviços Google,
DRM, jogos ou aplicativos que exigem certificação/Play Integrity.

# Programas Windows no DroidOS

Wine permite executar muitos aplicativos Windows sem instalar o Windows.
A primeira ISO inclui Wine 64-bit. Para programas antigos de 32-bit:

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install wine32:i386 libwine:i386
wineboot -u
```

Para executar um instalador:

```bash
wine ~/Downloads/instalador.exe
```

Compatibilidade varia por aplicativo. Programas que dependem de drivers
Windows, anti-cheat, .NET específico, DirectX recente ou componentes
proprietários podem não funcionar. Para consultar compatibilidade, use
o banco de dados do WineHQ: https://appdb.winehq.org/

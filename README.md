# My NixOS config
![screenshot of desktop + fastfetch](./img/sample.png)

# Commands
I place my configuration (this repo) at `~/nixos`.

Rebuild desktop:
```shell
sudo nixos-rebuild switch --flake ~/nixos#desktop
```

Rebuild laptop:
```shell
sudo nixos-rebuild switch --flake ~/nixos#yoga
```

Then on subsequent rebuilds it defaults to config matching hostname.
Can therefore use:
```shell
sudo nixos-rebuild switch --flake ~/nixos
```
on both systems.

## Running `Appimage` files

```shell
nix-shell -p appimage-run         # Enter nix shell with ability to run .AppImage files
appimage-run <something.AppImage> # Run AppImage
```

# TODO
- [ ] See hardware config for laptop: https://github.com/NixOS/nixos-hardware
- [ ] Cleanup `desktop`'s `configuration.nix` and `home.nix`
- [ ] Setup cleanup of storage + nix-store (https://nixos.wiki/wiki/Cleaning_the_nix_store, https://nixos.wiki/wiki/Storage_optimization)

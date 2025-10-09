# Commands
I place my configuration (this repo) at `~/nixos`.

Rebuild :
```shell
sudo nixos-rebuild switch --flake ~/nixos#{SYSTEM}

# Rebuild laptop:
sudo nixos-rebuild switch --flake ~/nixos#nyx

# Rebuild desktop
sudo nixos-rebuild switch --flake .#atlas
```

## Running `Appimage` files

```shell
nix-shell -p appimage-run         # Enter nix shell with ability to run .AppImage files
appimage-run <something.AppImage> # Run AppImage
```

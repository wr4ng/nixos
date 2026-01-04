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

## Cleanup and generations
List nix generations:
```shell
sudo nix-env -p /nix/var/nix/profiles/system --list-generations
```

Delete all older generations (and store entries):
```shell
sudo nix-collect-garbage --delete-old
```

# NixOS Configuration
I place my configuration (this repo) at `~/nixos`.

Rebuild:
```shell
sudo nixos-rebuild switch --flake .#{SYSTEM}

# Rebuild laptop:
sudo nixos-rebuild switch --flake ~/nixos#nyx

# Rebuild desktop
sudo nixos-rebuild switch --flake .#prometheus
```

After that `nh` can be used to rebuild and switch to new generations:
```shell
nh os switch .
nh os boot .
```

`nh` can also be used to cleanup previous generations and the nix-store:
```shell
nh clean all --keep 1   # --dry
```

## Running `Appimage` files

```shell
nix-shell -p appimage-run         # Enter nix shell with ability to run .AppImage files
appimage-run <something.AppImage> # Run AppImage
```

# TODO
- [ ] Move Limine + Secure Boot configuration to a NixOS module.
- [ ] Create Gnome module

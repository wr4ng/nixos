Rebuild desktop:
```shell
sudo nixos-rebuild switch --flake ~/nixos#desktop
```

Rebuild laptop:
```shell
sudo nixos-rebuild switch --flake ~/nixos#yoga
```

# TODO
- [ ] See hardware config for laptop: https://github.com/NixOS/nixos-hardware
- [ ] Move hyprland config to a NixOS module (that also declares home-manager options)
- [ ] Cleanup `desktop`'s `configuration.nix` and `home.nix`

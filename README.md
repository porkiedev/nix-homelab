# Custom Packages, Overlay, and anything else pertaining to Nix in the context of my homelab or otherwise
## Packages

- **multimon-ng** - The [multimon-ng](https://github.com/EliasOenal/multimon-ng) package. Based on the master branch at the time of writing, since the standard nixpkgs version is too outdated for my use case
- **squelch-collector** - [squelch-collector](https://github.com/porkiedev/squelch-collector/)
- **mercury** - The [mercury](https://github.com/Rhizomatica/mercury) HF modem

## Usage

You can use this flake on any NixOS machine with one of the following methods:

- Use it directly with: `nix run github:username/nix-homelab#packagename`. This is useful for testing or using a specific package
- Add it as an overlay to your system flake. Now you can use any of my package definitions as `pkgs.package_name`, etc.

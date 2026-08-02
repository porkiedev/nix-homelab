# Custom Packages, Overlay, and anything else pertaining to Nix in the context of my homelab or otherwise
## Packages

- **multimon-ng** - The [multimon-ng](https://github.com/EliasOenal/multimon-ng) package. Based on the master branch at the time of writing, since the standard nixpkgs version is too outdated for my use case
- **squelch-collector** - [squelch-collector](https://github.com/porkiedev/squelch-collector/)
- **mercury** - The [mercury](https://github.com/Rhizomatica/mercury) HF modem
- **rtltcp2026** - The [rtltcp2026](https://github.com/dlasher/rtltcp2026) package. This is a rust rewrite of rtl_tcp with many improvements

## Usage
You can use the provided packages via a nixpkgs overlay in your configuration.nix:

```nix
nixpkgs.overlays = [
  (final: prev: {
    multimon-ng = prev.callPackage ./nix-homelab/packages/multimon-ng.nix {};
    mercury = prev.callPackage ./nix-homelab/packages/mercury.nix {};
    squelch-collector = prev.callPackage ./nix-homelab/packages/squelch-collector.nix {};
    rtltcp2026 = prev.callPackage ./nix-homelab/packages/rtltcp2026.nix {};
  })
];
```
Then you are free to add these packages to your system or user packages as you would normally, i.e. with something like `pkgs.squelch-collector`.
Keep in mind that the paths included in the example are pointing to the corresponding nix files. **Your configuration needs to, too.**
In my case, I just clone this repo into `/etc/nixos` and this works perfectly.

## Notes
I am using oxalica's rust-overlay to create a new rustPlatform for building squelch-collector (and probably future rust projects) for the reasons outlined in [this issue](https://github.com/rust-lang/rust/issues/159669)

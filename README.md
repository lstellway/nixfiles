## NixOS host configurations

My Nix configuration files!

### Installation

**Install NixOS**

Install NixOS using the [official NixOS installer](https://nix.dev/install-nix.html):
```
make deps
```

**Darwin**

Install Flake using [nix-darwin](https://github.com/LnL7/nix-darwin):
```
make init-darwin
```

Rebuild Darwin machine configuration:
```
make darwin
```

### Structure

- `modules`
  - `modules.nix` - helper for including modules in various contexts *(Darwin, NixOS, Home Manager, etc..)*
  - `common` - shared OS-level modules
  - `darwin` - modules specific to Darwin
  - `nixos` - modules specific to NixOS
  - `home-manager` - shared Home Manager modules

### To do

- [ ] Configure git
- [ ] SSH configuration?
- [ ] GPG key management?


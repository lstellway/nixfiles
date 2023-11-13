## NixOS host configurations

My Nix configuration files!

### Installation

**Darwin**

Initialize machine:
```
make darwin
```

Rebuild:
```
make darwin-rebuild
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


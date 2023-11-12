## NixOS host configurations

After dabbling with [Chezmoi](https://chezmoi.io), I am beginning to incorporate Nix into my workflow to manage dotfiles and machine configuration.

It was definitely a bit of a challenge to get started and accomplish what I was after, but I'm starting to get the hang of it and am pretty happy with the direction of my setup.

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

### To do

- [ ] Configure git
- [ ] SSH configuration
- [ ] Darwin
  - [ ] How to get Spotlight to index Applications? (see [issue #7055](https://github.com/NixOS/nix/issues/7055))
    - My workaround for now is to manage anything GUI apps (casks) with Homebrew
    - It doesn't look like the CLI binaries that ship with casks (VLC, VSCode, etc..) are available


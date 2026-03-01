## Nix / nix-darwin / Home Manager configuration

My Nix configuration files for macOS (Darwin).

### Dependencies

- [Nix](https://github.com/DeterminateSystems/nix-installer) (Determinate Systems installer)
- [nix-darwin](https://github.com/LnL7/nix-darwin) — macOS system configuration
- [Home Manager](https://nix-community.github.io/home-manager/) — user environment configuration

Pinned to `nixos-25.11`.

### Installation

**Install Nix**

```
make deps
```

**Initialize Darwin (first time only)**

```
make darwin-init
```

**Rebuild Darwin configuration**

```
make darwin
```

**Update flake inputs** (e.g. when upgrading nixpkgs)

```
make darwin-update
```

### Structure

- `flake.nix` — entry point; defines inputs and `darwinConfigurations` hosts
- `modules/`
    - `modules.nix` — auto-discovers and loads `.inc.nix` files per context
    - `common/` — shared OS-level packages
    - `darwin/` — Darwin system config (packages, fonts, system settings, scripts)
    - `nixos/` — NixOS-specific packages _(no NixOS hosts currently configured)_
    - `home-manager/` — per-user Home Manager modules:
        - `fzf` — fuzzy finder
        - `gh` — GitHub CLI
        - `git` — git config
        - `k9s` — Kubernetes TUI
        - `shell` — zsh config and shell scripts (AWS, containers, git, Node, SSH, tmux, etc.)
        - `ssh` — SSH client config
        - `tmux` — tmux config
        - `vim` — Neovim/Vim with plugins and init scripts

### Hosts

| Hostname | System           | Users   |
| -------- | ---------------- | ------- |
| `banana` | `aarch64-darwin` | `logan` |

### To do

- [ ] GPG key management

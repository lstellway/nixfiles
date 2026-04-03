## Nix / nix-darwin / Home Manager configuration

My Nix configuration files for macOS (Darwin).

If you're new to Nix, this repo can serve as a starting point for managing your macOS system configuration and dotfiles declaratively. Everything — system packages, shell config, editor setup, fonts, macOS preferences — is defined in code and reproducible.

### Key concepts

This configuration uses three tools from the Nix ecosystem:

- **[Nix](https://github.com/DeterminateSystems/nix-installer)** — a package manager that installs software in isolation, so packages never conflict with each other.
- **[nix-darwin](https://github.com/LnL7/nix-darwin)** — uses Nix to configure macOS system-level settings (like `defaults write` commands, Homebrew packages, fonts, and launch daemons).
- **[Home Manager](https://nix-community.github.io/home-manager/)** — uses Nix to configure per-user programs and dotfiles (shell, git, editor, tmux, etc.).

All three are wired together in a [Nix flake](https://nix.dev/concepts/flakes.html) — a single entry point (`flake.nix`) that pins exact versions of all dependencies.

Pinned to `nixos-25.11`.

### Dependencies

- [Nix](https://github.com/DeterminateSystems/nix-installer) (Determinate Systems installer)

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

### How it works

The entry point is `flake.nix`. It defines:

1. **Inputs** — pinned versions of nixpkgs, nix-darwin, and home-manager
2. **Outputs** — one or more host configurations (currently just `banana`)

Each host imports modules from `modules/`. Modules are organized by context:

```
modules/
├── modules.nix       # Auto-discovery engine (finds .inc.nix files)
├── common/           # Packages shared across all systems
├── darwin/           # macOS system config (Homebrew, fonts, preferences)
├── nixos/            # NixOS config (unused — no NixOS hosts yet)
└── home-manager/     # Per-user config (shell, git, neovim, tmux, etc.)
```

#### The `.inc.nix` convention

Any file ending in `.inc.nix` is **automatically discovered and imported** by `modules/modules.nix`. This means you can add a new module just by creating a file — no manual import list to update.

For example, to add a new Home Manager module:

1. Create `modules/home-manager/my-tool/my-tool.inc.nix`
2. Write a Nix function: `{ pkgs, ... }: { programs.my-tool.enable = true; }`
3. Run `make darwin` — it's automatically picked up

Files named `default.nix` are **not** auto-discovered. They serve as entry points that orchestrate imports and wire things together.

#### Homebrew vs Nix

- **Nix** is used for CLI tools and libraries (`modules/common/packages.inc.nix`)
- **Homebrew** is used for GUI applications (`modules/darwin/packages.inc.nix`) so they appear in `/Applications` and are available via Spotlight search. [Nix-installed GUI apps don't integrate well with Spotlight.](https://github.com/NixOS/nix/issues/7055)

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
        - `git` — git config (SSH-based commit signing)
        - `k9s` — Kubernetes TUI
        - `neovim` — editor with LSP, fuzzy finder, and markdown support
        - `shell` — zsh config and [shell scripts](modules/home-manager/shell/README.md)
        - `ssh` — SSH client config
        - `tmux` — tmux config

### Hosts

| Hostname | System           | Users   |
| -------- | ---------------- | ------- |
| `banana` | `aarch64-darwin` | `logan` |

### Adding a new host

In `flake.nix`, add an entry to `darwinConfigurations`:

```nix
my-host = import ./modules/darwin (inputs // {
  system = "aarch64-darwin";
  users = {
    my-user = { directory = "/Users/my-user"; };
  };
});
```

Then run `make darwin` on the new machine.

### To do

- [ ] GPG key management

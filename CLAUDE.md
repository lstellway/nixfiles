# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Nix flake managing macOS (nix-darwin) system and user (Home Manager) configuration for Apple Silicon. Pinned to `nixos-25.11`. Single host: `banana` (aarch64-darwin, user: logan).

## Build Commands

```bash
make darwin            # Rebuild system configuration (requires sudo)
make darwin-init       # First-time initialization after installing Nix
make darwin-update     # Update flake.lock inputs
make darwin-backup     # Backup /etc shell configs that conflict with nix-darwin
```

## Architecture

**Flake inputs:** `nixpkgs`, `nix-darwin`, `home-manager` — all pinned to 25.11 releases. Inputs are merged and propagated to modules via `inputs // { system, users }`.

**Module auto-discovery:** `modules/modules.nix` recursively finds all `.inc.nix` files per context directory (common, darwin, nixos, home-manager). To add a new module, create a `.inc.nix` file in the appropriate directory — it will be auto-imported.

**Module contexts:**
- `modules/common/` — packages shared across all systems
- `modules/darwin/` — Darwin system config (Homebrew, fonts, macOS settings). Entry point: `darwin/default.nix`
- `modules/nixos/` — NixOS packages (no hosts currently configured)
- `modules/home-manager/` — per-user config (shell, git, neovim, tmux, etc.). Entry point: `home-manager/default.nix`

**Home Manager integration:** Wired into Darwin via `home-manager.darwinModules.home-manager`. Per-user configuration mapped through `home-manager.users`.

**Neovim config:** Lua-based, split across `modules/home-manager/neovim/init/` files (options, keymaps, lsp, plugins, markdown) which are concatenated in order. See `modules/home-manager/neovim/README.md`.

**Shell scripts:** Not auto-discovered — must be manually listed in `zsh.inc.nix`. See `modules/home-manager/shell/README.md`.

**Homebrew vs Nix:** GUI apps go in Homebrew (`darwin/packages.inc.nix`) for Spotlight integration. CLI tools go in Nix (`common/packages.inc.nix`).

## Conventions

- Default git branch is `develop` (not main)
- Git pull strategy is rebase
- Commit signing uses SSH (ED25519), not GPG
- Each `.inc.nix` module is a function taking `{ pkgs, lib, ... }`
- `default.nix` files are entry points that import and orchestrate; `.inc.nix` files are auto-discovered includes

# Nix Technology Expert — Sources

References that informed the content in `technology-nix.md`. Prioritizes authoritative sources; community resources are noted where they fill gaps not covered officially.

## Official Documentation

- [nix.dev — Nix Documentation Hub](https://nix.dev) — official home of Nix ecosystem documentation, maintained by the NixOS Foundation. Covers tutorials, guides, reference links, and concepts including flakes and the Nix language.
- [Nix Reference Manual](https://nix.dev/manual/nix/stable/) — Nix CLI commands, language reference, builtins, and package management concepts. Canonical URL as of 2025 (nixos.org/manual/nix/stable/ redirects here).
- [Nix Language Tutorial](https://nix.dev/tutorials/nix-language.html) — official tutorial for the Nix expression language, part of nix.dev.
- [Nixpkgs Reference Manual](https://nixos.org/manual/nixpkgs/stable/) — stdenv, overlays, override mechanisms (override/overrideAttrs), fetchers, language framework helpers, lib functions (strings, lists, attrsets), cross-compilation.
- [NixOS Search — Packages](https://search.nixos.org/packages) — canonical nixpkgs package search interface.
- [NixOS Search — Options](https://search.nixos.org/options) — NixOS module options, searchable.
- [Home Manager Options Reference](https://nix-community.github.io/home-manager/options.xhtml) — full declarative options for Home Manager modules, maintained by nix-community. Each option includes type, default, and examples.
- [nix-darwin Manual](https://nix-darwin.github.io/nix-darwin/manual/) — nix-darwin configuration options. Canonical URL as of 2025; project moved from LnL7/nix-darwin to the nix-darwin GitHub organization (daiderd.com/nix-darwin/manual/ redirects here).
- [Official NixOS Wiki](https://wiki.nixos.org) — maintained by the NixOS Foundation. Preferred over the older community wiki (nixos.wiki) for authoritative guidance.
- [Noogle — Nix Function Search](https://noogle.dev) — searchable index of Nix builtins and nixpkgs lib functions with signatures and examples.
- [Nix Pills](https://nixos.org/guides/nix-pills/) — deep-dive series building understanding of Nix from first principles: how derivations work, how nixpkgs is constructed. Semi-official; hosted on nixos.org.

## Community Resources

- [nix-community/awesome-nix](https://github.com/nix-community/awesome-nix) — curated index of Nix resources: CLI tools (alejandra, nixfmt, nil, nixd, statix, nix-index), deployment tools, overlays, and language integrations. Used to validate ecosystem coverage.
- [Zero to Nix (Determinate Systems)](https://zero-to-nix.com) — beginner-friendly, flakes-first guide. Used to verify flake output schema conventions.
- [NixOS and Flakes Book](https://nixos-and-flakes.thiscute.world/) — community book covering NixOS + Flakes in depth (ryan4yin). Used to cross-check module system documentation.
- [NixOS Discourse](https://discourse.nixos.org/) — primary community Q&A forum. Referenced for common patterns and edge cases not covered in official docs.
- [Practical Nix Flake Anatomy](https://vtimofeenko.com/posts/practical-nix-flake-anatomy-a-guided-tour-of-flake.nix/) — community walkthrough of flake.nix structure. Used to validate flake output attribute conventions.

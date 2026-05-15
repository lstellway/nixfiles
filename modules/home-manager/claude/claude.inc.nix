# Claude Code configuration
#
# Symlinks user-authored skills and agents from this repo into ~/.claude
# via mkOutOfStoreSymlink, so files remain writable in the working tree
# (no rebuild required when adding or editing a skill).
#
# settings.json, plugins/, and runtime dirs (sessions/, history.jsonl,
# cache/, etc.) are intentionally not managed — settings.json may grow
# secrets (MCP tokens), and runtime dirs are per-machine state.
{ config, ... }:
let
  repoClaudeDir = "${config.home.homeDirectory}/go/src/github.com/lstellway/nixfiles/modules/home-manager/claude";
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    ".claude/skills".source = link "${repoClaudeDir}/skills";
    ".claude/agents".source = link "${repoClaudeDir}/agents";
  };
}

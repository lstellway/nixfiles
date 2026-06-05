# Claude Code configuration
#
# Manages user-authored skills and agents from this repo into ~/.claude.
# Edits require a rebuild to take effect.
#
# settings.json, plugins/, and runtime dirs (sessions/, history.jsonl,
# cache/, etc.) are intentionally not managed — settings.json may grow
# secrets (MCP tokens), and runtime dirs are per-machine state.
{ ... }: {
  home.file = {
    ".claude/skills".source = ./skills;
    ".claude/agents".source = ./agents;
  };
}

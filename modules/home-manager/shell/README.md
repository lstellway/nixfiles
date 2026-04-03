## Shell

Zsh configuration and custom shell scripts managed via Home Manager.

### How it works

`zsh.inc.nix` concatenates all scripts from `scripts/` into the zsh `initContent`, so every function and alias is available in every shell session. Aliases are also defined declaratively in `aliases.inc.nix` via Home Manager's `home.shellAliases`.

### Scripts

| Script | Functions / Purpose |
|--------|-------------------|
| `aliases.sh` | `empty` (truncate files), `dictionary` (look up words via DICT protocol), `dotenv` (source `.env` files), `rmount` (mount rclone remotes) |
| `aws.sh` | `aws-do` (DigitalOcean Spaces endpoint), `aws-cf` (Cloudflare R2 endpoint), `aws-profile` (switch AWS profile) |
| `containers.sh` | `docker-ssh-sessions` / `docker-kill-ssh-sessions` (find/kill stale Docker SSH connections), adds Rancher Desktop to PATH |
| `env.sh` | Loads `~/.env` if present, adds `~/bin` and `~/.local/bin` to PATH |
| `git.sh` | Git aliases (`ga`, `gd`, `gw`, `gpc`, `gpo`, `gfo`, `gbn`, `gbd`, `gitl`) |
| `homebrew.sh` | Initializes Homebrew, `brew-dir` (get installed package directory) |
| `node.sh` | Initializes [fnm](https://github.com/Schniz/fnm) (Fast Node Manager) |
| `prompt.zsh` | Zsh prompt with git branch/status via `vcs_info` |
| `ssh.sh` | `ssh-sessions` / `ssh-kill-sessions` (find/kill SSH control sockets), `ssh_set_port` (change macOS SSH listen port) |
| `terminal.sh` | `terminal-profile` (switch macOS Terminal.app theme via AppleScript) |
| `timer.sh` | `timer` (countdown timer with optional text-to-speech announcement) |
| `yt.sh` | `yt-title` (get YouTube video title), `yt-transcript` (download auto-generated transcript) |

### Aliases

Quick aliases defined in `aliases.inc.nix`:

| Alias | Command |
|-------|---------|
| `c` | `clear` |
| `ll` | `ls -lAh` |
| `cl` | `clear && ls -lAh` |
| `..` / `...` / `....` | Navigate up directories |
| `tmux-dir` | New tmux session named after current directory |
| `ports_tcp` / `ports_udp` | Show ports in use |

### Adding a new script

1. Create a new `.sh` file in `scripts/`
2. Add the file path to the list in `zsh.inc.nix`
3. Run `make darwin`

Note: unlike `.inc.nix` files, shell scripts are **not** auto-discovered. You must add them to the list in `zsh.inc.nix` manually.

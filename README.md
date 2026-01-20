This repo is the source of truth for my system configs. The real files live in
`/home/johnny/dotfiles`, and `~` points to them via symlinks. For example:
`~/.config/nvim` → `/home/johnny/dotfiles/.config/nvim`. For opencode,
`~/.config/opencode/opencode.json` → `/home/johnny/dotfiles/.config/opencode/opencode.json`.
The system reads the symlinked paths, so edits should be made directly in this repo.

Structure map (symlinked targets):
- `.config/nvim`
- `.config/hypr`
- `.config/ghostty`
- `.config/tmux`
- `.config/yazi`
- `.config/waybar`
- `.config/opencode/opencode.json`
- Dotfiles like `.bashrc` and `.tmux.conf`

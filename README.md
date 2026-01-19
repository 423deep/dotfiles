This repo is the source of truth for my system configs. The real files live in
`/home/johnny/dotfiles`, and `~` points to them via symlinks. For example:
`~/.config/nvim` → `/home/johnny/dotfiles/.config/nvim`. The system reads the
symlinked paths, so edits should be made directly in this repo.

Structure map (symlinked targets):
- `.config/nvim`
- `.config/hypr`
- `.config/ghostty`
- `.config/tmux`
- `.config/yazi`
- `.config/waybar`
- Dotfiles like `.bashrc` and `.tmux.conf`

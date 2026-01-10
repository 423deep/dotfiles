Your setup is: the real configs live in /home/johnny/dotfiles, and ~ points to them via symlinks. For example ~/.config/nvim -> /home/johnny/dotfiles/.config/nvim, and likewise for
  hypr, ghostty, tmux, yazi, waybar, plus dotfiles like .bashrc, .tmux.conf, etc. You edit in dotfiles, and the system reads through the symlinked paths.

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Auto-start tmux on login if not already inside a session.
if command -v tmux >/dev/null && [ -z "$TMUX" ]; then
  tmux new-session -A -s main
fi

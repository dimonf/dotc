export ZDOTDIR=~/.config/zsh
export PATH="$PATH:"~/.cargo/bin:~/.luarocks/bin
#stolen from Luck Smith shell profile:
export PATH="$PATH:${$(find ~/.local/bin.my -type d -printf %p:)%%:}"

#https://wiki.archlinux.org/title/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1W > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# base config for oh my zsh
source /usr/share/oh-my-zsh/zshrc

#p10k instant prompt to make terminal open a bit snappier
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source manjaro config
source ~/.zshrc

# fix for comment color on manjaro zsh theme
if [ -z $ZSH_QUICK ]; then
  ZSH_HIGHLIGHT_STYLES[comment]='fg=blue'
fi

# user-defined overrides
[ -d ~/.config/zsh/config.d/ ] && source <(cat ~/.config/zsh/config.d/*)

# Fix for foot terminfo not installed on most servers
alias ssh="TERM=xterm-256color ssh"

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

plugins=(fzf jump)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export ZSH_THEME=robbyrussell

##### autocomplete for jump plugin
#https://datascienceworkshops.com/blog/quickly-navigate-your-filesystem-from-the-command-line/
function _completemarks {
  reply=($(ls $MARKPATH))
}
compctl -K _completemarks jump
compctl -K _completemarks unmark
#

source $ZSH/oh-my-zsh.sh

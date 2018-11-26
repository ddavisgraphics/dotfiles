[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#respects .agignore but not .gitignore and shows hidden. Also used by vim-fzf
export FZF_DEFAULT_COMMAND='ag -Ug "" --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_OPTS='-m'

#rebind the the cd widget, normally alt-c cause I can't alt
bindkey '^Y' fzf-cd-widget

# make z use fzf
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}



###############################################################################
# DEFAULTS
###############################################################################
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

###############################################################################
# PLUGINS
###############################################################################
plugins=(
  git
  gitfast
  dotenv
  macos
  rake
  ruby
  tmux
)

source $ZSH/oh-my-zsh.sh

###############################################################################
# MAY NOT NEED AFTER SWITCHING TO ASDF
###############################################################################
# export PATH="/usr/local/sbin:$PATH"
# alias pull="git pull --ff-only"
# alias killiTerm2='killall iTerm2'

###############################################################################
# MAY NOT NEED ON NEW SYSTEM IDK
###############################################################################
# vscode() { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
# alias code="vscode"
# export EDITOR="vscode"

###############################################################################
# DEFAULT CONFIG CHANGES
###############################################################################
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias zsh_reset="source ~/.zshrc"

DISABLE_AUTO_TITLE="true"

###############################################################################
# ASDF
###############################################################################
# . "$HOME/.asdf/asdf.sh"
# . "$HOME/.asdf/completions/asdf.bash"

###############################################################################
# Convinience Functions
###############################################################################
find_file() {
  find $1 -type f -name $2
}

local_ip() {
  ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2
}

timed_bin_reset() {
  ruby ~/ruby_scripts/time_task.rb
}

disappointed() { echo -n " ಠ_ಠ " }
flip() { echo -n "（╯°□°）╯ ┻━┻" }
shrug() { echo -n "¯\_(ツ)_/¯" }

alias weather="curl -4 http://wttr.in/Leavittsburg"

###############################################################################
# Load all the BoldPenguin Stuff
###############################################################################
export ZSH="~/dotfiles/zsh"
for file in "$ZSH/boldpenguin"/*.zsh; do
  source "$file"
done
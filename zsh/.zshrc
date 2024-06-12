

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
  asdf
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
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PGGSSENCMODE="disable"
export PARALLEL_PROCESSOR_COUNT=4

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
# POSGRES RAILS/PG GEM REQUIREMENTS
###############################################################################
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"

###############################################################################
# ASDF
###############################################################################

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

for file in ~/dotfiles/zsh/boldpenguin/*(.); do
  source $file
done

###############################################################################
# APPLE DOCK
###############################################################################
function add_spacer {
  defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="'$1'";}'
  killall Dock
}
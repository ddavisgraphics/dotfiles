###############################################################################
# EXPORTS
###############################################################################
export EDITOR="code -w"

export BP_APP_ROOT="$HOME/Desktop/boldpenguin"
export APP="$BP_APP_ROOT"

export DATABASE_HOST="localhost"
export DATABASE_PORT="5432"


export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000000
export SAVEHIST=10000000000
setopt EXTENDED_HISTORY

###############################################################################
# PARTNER ENGINE BIN/RESET
###############################################################################
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PGGSSENCMODE="disable"
export PARALLEL_PROCESSOR_COUNT=4
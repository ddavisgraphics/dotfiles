mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
[[ ! -e $XDG_CONFIG_HOME/nvim ]] && ln -s ~/.vim $XDG_CONFIG_HOME/nvim
[[ ! -e $XDG_CONFIG_HOME/nvim/init.vim ]] && ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

# fixes a bug related to mapping <c-h> in MacOS with Tmux
# https://github.com/neovim/neovim/issues/2048
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $HOME/$TERM.ti
tic $HOME/$TERM.ti

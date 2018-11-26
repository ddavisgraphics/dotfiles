# copy the active line from the command line onto the clipboard
#linux and macos

zle -N copycmd

bindkey "^O" copycmd

copycmd () {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo $BUFFER | xclip -sel clip
  elif [[ "$OSTYPE" == "darwin" ]]; then
    echo $BUFFER | pbcopy
  fi
}

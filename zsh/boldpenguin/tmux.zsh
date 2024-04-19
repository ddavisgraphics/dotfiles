###############################################################################
# TMUX Functions
###############################################################################

alias mux="tmuxinator"
export DISABLE_AUTO_TITLE="true"

kill_tmux() {
  if [[ ${1:+present} ]]
    then
      tmux kill-session -t $1
    else
      tmux kill-session -t penguins
  fi
}

wait_for_auth() {
  echo "Waiting for auth to start"

  while ! $(lsof -i tcp:3000 >/dev/null)
  do
    sleep 1
  done

  echo "Auth Started ... moving on."
}

wait_for_pe() {
  echo "Waiting for PE to start"

  while ! $(lsof -i tcp:8080 >/dev/null)
  do
    sleep 1
  done

  echo "PE Started ... moving on."
}
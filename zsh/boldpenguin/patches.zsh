###############################################################################
# Patches
###############################################################################

bp_run() {
  echo "rake patches:run\[${1}\] - started"
  rails patches:run\[${1}\]
}

bp_run_command() {
  echo "rails patches:run\[${1}\]"
}

bp_patch() {
  if [[ ${1:+present} ]]
    then
      rails generate bp_patch:patch ${1}
    else
      TITLE=$(git rev-parse --abbrev-ref HEAD)
      rails generate bp_patch:patch ${TITLE}
  fi
}

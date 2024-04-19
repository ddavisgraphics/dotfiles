###############################################################################
# Patches
###############################################################################

bp_run() {
  rails patches:run\[${1}\]
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
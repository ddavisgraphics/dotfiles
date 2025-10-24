###############################################################################
# PE Functions
###############################################################################
start_pe() {
  {PE} && rails log:clear && {update} && {reset_today} && bin/server
}

pe_pryable() {
  bundle exec puma -w 1 -p 8080
}

ce_pryable() {
  bundle exec puma -w 1 -p 3002
}

update_ce() {
  git stash && git pull --ff-only && bundle install  && rails db:migrate && rails patches:all && bin/server
}

rule_count() {
  BRANCH=$(git branch --show-current)
  rails debug:counts >> debug_counts_${BRANCH}.txt
  rails debug:dump_rules && mv tmp/rules_dump.txt debug_rules_dump_${BRANCH}.txt
}
alias rc=rule_count

remove_screenshots() {
  TMP_PATH='/Users/dave.davis/Desktop/boldpenguin/carrier-engine/tmp'
  cd $TMP_PATH && rm -rf ./*.png
}

restore_pe() {
  BACKUP=$( ls -t tmp/dbs | head -n1 )
  print "Restoring from $BACKUP"
  psql -f tmp/dbs/$BACKUP postgres
}

restore_last_dump() {
  LAST_FILE=$(ls -t $APP/partner-engine/tmp/dbs | head -n1)
  psql -f $APP/partner-engine/tmp/dbs/$LAST_FILE postgres
}

creds() {
  cd $APP/authenticator
  EDITOR="code --wait" bin/rails credentials:edit
}

# Generate new command, response, and test files for Partner Engine
# Works from any directory by changing to the partner-engine base directory
# @param $1 command_name - The name of the command to generate (e.g., "create_policy")
# @param $2 namespace - The namespace for the command (e.g., "blitz", "progressive", "safeco")
generate_command() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Error: Please provide both command name and namespace"
    echo "Usage: generate_command <command_name> <namespace>"
    return 1
  fi

  local command_name="$1"
  local namespace="$2"
  local script_path="$HOME/dotfiles/ruby_scripts/generate_command.rb"

  # Check if the Ruby script exists
  if [[ ! -f "$script_path" ]]; then
    echo "Error: Ruby script not found at $script_path"
    return 1
  fi

  # Run the Ruby script to generate files (script handles directory change)
  ruby "$script_path" "$command_name" "$namespace"
}

alias gencmd=generate_command

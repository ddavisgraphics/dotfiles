
###############################################################################
# ALIAS
###############################################################################
alias reload!='. ~/.zshrc'
alias clr='clear' # Good 'ol Clear Screen command

###############################################################################
# CHANGING DIRECTORY TO PROJECT DIRS
###############################################################################
CE() { cd $APP/carrier-engine }
alias ce=CE
PE() { cd $APP/partner-engine }
alias pe=PE
AUTH() { cd $APP/authenticator }
alias auth=AUTH

aws_urls(){
  echo "AUTH: boldpenguin-auth-$1.canary.boldpenguin.com\n"
  echo "CE: carrier-engine-$1.canary.boldpenguin.com\n"
  echo "PE: partner-engine-$1.canary.boldpenguin.com\n"
  echo "Terminal: terminal-$1.canary.boldpenguin.com\n"
}

###############################################################################
# STABLE VERSIONS OF SOFTWARE FOR LATEST TAGS
###############################################################################

# RUBY
ruby_stable(){
  curl -s https://www.ruby-lang.org/en/downloads/ | grep -o 'The current stable version is [0-9]\+\.[0-9]\+\.[0-9]\+' | awk '{print $6}'
}

# Requires dos2unix to be installed
# Find and process changed CSV files compared to staging branch
fix_seeds() {
  # Move to git repository root for consistent behavior
  local repo_root=$(git rev-parse --show-toplevel)
  cd "$repo_root" || { echo "Failed to change to repository root"; return 1; }

  # Get all changed CSV files, including uncommitted changes
  local staging_branch="staging"

  # Check for uncommitted changes to CSV files
  local uncommitted_files=$(git diff --name-only --diff-filter=M | grep "\.csv$" || echo "")

  # Check for committed changes compared to staging branch
  local committed_files=$(git diff --name-only $staging_branch | grep "\.csv$" || echo "")

  # Combine both results and remove empty lines
  local all_changed_files=$(echo "$uncommitted_files"$'\n'"$committed_files" | grep -v "^$" | sort | uniq)

  if [ -z "$all_changed_files" ]; then
    echo "No CSV files have changed compared to staging."
    return 0
  fi

  echo "Found the following changed CSV files:"
  echo "$all_changed_files \n\n"

  # Process each file with dos2unix
  echo "$all_changed_files" | while read -r file; do
    if [ -f "$file" ]; then
      dos2unix "$file"
      sed -i '' 's/[[:space:]]*$//' "$file"  # Remove trailing whitespace
      echo "Converted line endings for: $file"
    fi
  done
}

# From Vinny, runs a bp rake task to diff questions.yml
# run as: debug chubbcarrier
debug(){
  rake debug:question_yml:staging_diff\[lib/seeds/$1/questions.yml\]
}


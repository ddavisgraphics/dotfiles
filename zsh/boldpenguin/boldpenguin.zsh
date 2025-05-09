
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


# line endings for appetites csvs
line_endings() {
    for file in ~/Desktop/boldpenguin/partner-engine/engines/appetite/lib/seeds/appetite/*.csv; do
        echo "Converting line endings for: $file"
        dos2unix "$file"
    done
}

# From Vinny, runs a bp rake task to diff questions.yml
# run as: debug chubbcarrier
debug(){
  rake debug:question_yml:staging_diff\[lib/seeds/$1/questions.yml\]
}


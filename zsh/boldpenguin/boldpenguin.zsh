
###############################################################################
# ALIAS
###############################################################################
alias reload!='. ~/.zshrc'
alias clr='clear' # Good 'ol Clear Screen command

###############################################################################
# CHANGING DIRECTORY TO PROJECT DIRS
###############################################################################
CE() { cd $APP/carrier-engine }
PE() { cd $APP/partner-engine }
RE() { cd $APP/rules-engine }
AUTH() { cd $APP/authenticator }s

###############################################################################
# Generate AWS Functions
###############################################################################
aws_urls(){
  echo "AUTH: boldpenguin-auth-$1.canary.boldpenguin.com\n"
  echo "CE: carrier-engine-$1.canary.boldpenguin.com\n"
  echo "PE: partner-engine-$1.canary.boldpenguin.com\n"
  echo "Terminal: terminal-$1.canary.boldpenguin.com\n"
}


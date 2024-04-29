
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
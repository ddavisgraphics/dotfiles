###############################################################################
# PE Functions
###############################################################################
start_pe() {
  {PE} && rails log:clear && {update} && {reset_today} && bin/server
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

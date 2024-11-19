###############################################################################
# OPENSEARCH PASSWORD
###############################################################################
export OPENSEARCH_INITIAL_ADMIN_PASSWORD='AReallyStrongPassword1234!'

###############################################################################
# DATABASE FUNCTIONS
###############################################################################
restore_auth_db(){
  DATE=$(date +%Y%m%d)
  psql -f $APP/files/auth-latest-${DATE}.sql postgres
}

save_db() {
  DATE=$(date +%Y%m%d)
  if [[ ${1:+present} ]]
    then
      echo "latest-staging-${DATE}-${1}.sql"
      pg_dumpall -c > $APP/files/latest-staging-${DATE}-$1.sql
    else
      echo "latest-staging-${DATE}.sql"
      pg_dumpall -c > $APP/files/latest-staging-${DATE}.sql
  fi
}

save_auth_db() {
  DATE=$(date +%Y%m%d)
  if [[ ${1:+present} ]]
    then
      echo "auth-latest-${DATE}-${1}.sql"
      pg_dump 'authenticator_development' > $APP/files/auth-latest-${DATE}-$1.sql
    else
      echo "auth-latest-${DATE}.sql"
      pg_dump 'authenticator_development' > $APP/files/auth-latest-${DATE}.sql
  fi
}

load_db(){
  if [[ ${1:+present} ]]
    then
      psql -f $1 postgres
    else
      echo "Enter the name of the database file"
  fi
}

reset_today() {
  LAST_FILE=$(ls -t $APP/partner-engine/tmp/dbs | head -n1)
  if [[ $LAST_FILE == *$(date +%Y%m%d)* ]]
    then
      echo "No need to reset, moving on."
    else
     bin/reset
  fi
}
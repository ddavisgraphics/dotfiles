###############################################################################
# Rails Functions
###############################################################################
app-reset() {
  bin/rails db:reset && bin/server
}

update_db() {
  rails db:migrate && rails patches:all
}

update() {
  git pull --ff-only && bundle install
}

upstart() {
  rails log:clear && git pull --ff-only && bundle install && rails db:migrate && rails patches:all && bin/server
}

bs() {
  tmp_path=$(pwd)
  if [[ $tmp_path =~ 'partner-engine' ]]; then
    echo "Starting Partner Engine in single threaded mode..."
    bundle exec puma -w 1 -p 8080
  else
    echo "Not PE using bin/server"
    bin/server
  fi
}

clobber_logs() {
  rake log:clear
}

find_rake() {
  rake -T | grep $1
}
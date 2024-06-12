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
  bin/server
}

clobber_logs() {
  rake log:clear
}

find_rake() {
  rake -T | grep $1
}
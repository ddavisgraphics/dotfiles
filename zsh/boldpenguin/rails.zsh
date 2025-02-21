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
  git pull --ff-only && bundle install && rails log:clear && rails db:migrate && rails patches:all && bin/server
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

# profile_rake() {
#   ruby -Ilib -S ruby-prof -p graph_html /Users/daviddavis/.asdf/shims/rake $1 > tmp/profile.html
# }
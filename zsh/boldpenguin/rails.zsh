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

# test_pr - Run rails test only on test files changed vs a base branch (default: origin/master)
# Usage: test_pr [base_branch]
test_pr() {
  local base=${1:-origin/master}
  local files=$(git diff "${base}...HEAD" --name-only | grep "^test/.*\.rb$")
  if [[ -z "$files" ]]; then
    echo "No changed test files found vs ${base}"
    return 0
  fi
  bundle exec rails test ${(f)files}
}

# profile_rake() {
#   ruby -Ilib -S ruby-prof -p graph_html /Users/daviddavis/.asdf/shims/rake $1 > tmp/profile.html
# }
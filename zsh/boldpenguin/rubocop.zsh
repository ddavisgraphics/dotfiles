###############################################################################
# Rubocop
# cop - Run rubocop on all files that have been added or modified
# fix_cop - rubocop -A on all files that have been modified
# cop_mods - rubocop -A on all ruby files that have a diff
###############################################################################

cop() {
  git diff origin/staging... --name-only --diff-filter=AM | \
            xargs bundle exec rubocop \
              --parallel \
              --fail-level convention \
              --display-only-fail-level-offenses \
              --display-style-guide \
              --force-exclusion
}
alias cops=cop

cop_mods() {
  git diff origin/staging --name-only | grep '\.rb$' | xargs bundle exec rubocop --autocorrect --parallel
}

fix_cop() {
  git diff origin/staging... --name-only --diff-filter=AM | \
            xargs bundle exec rubocop \
              --parallel \
              --display-style-guide \
              --force-exclusion \
              --autocorrect
}
alias fix_cops=fix_cop
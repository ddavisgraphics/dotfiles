###############################################################################
# Rubocop
# cop - Run rubocop on all files that have been added or modified
# fix_cop - rubocop -A on all files that have been modified
# cop_mods - rubocop -A on all ruby files that have a diff
###############################################################################

cop() {
  { git diff origin/master --name-only --diff-filter=AM; git ls-files --others --exclude-standard; } | \
            xargs bundle exec rubocop \
              --parallel \
              --fail-level convention \
              --display-only-fail-level-offenses \
              --display-style-guide \
              --force-exclusion
}
alias cops=cop

# fix_cops() {
#   git diff origin/staging --name-only | grep '\.rb$' | xargs bundle exec rubocop --autocorrect --parallel
# }

fix_cop() {
  { git diff origin/master --name-only --diff-filter=AM; git ls-files --others --exclude-standard; } | \
            xargs bundle exec rubocop \
              --parallel \
              --display-style-guide \
              --force-exclusion \
              --autocorrect
}
alias fix_cops=fix_cop

# cop_pr - Run rubocop only on Ruby files changed vs a base branch (default: origin/master)
# Usage: cop_pr [base_branch]
cop_pr() {
  local base=${1:-origin/master}
  git diff "${base}...HEAD" --name-only | grep -E "^(app|test|lib)/.*\.rb$" | xargs bundle exec rubocop
}
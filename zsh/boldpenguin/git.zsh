###############################################################################
# CUSTOM GITHUB FUNCTIONS FOR BP WORK
###############################################################################

gfco() {
  git stash && git checkout $1
}

squash_merge() {
  git checkout $BRANCH
  git reset $(git merge-base staging $(git branch --show-current))
  git add -A
  git commit -m "Squashing commits from WIP: $BRANCH"
}

git_cops(){
  git add . && git commit -m "Fixing Rubcop" && git push
}

# This function will automatically request reviews on a github repo.
# Requires that have your PAT as a enviormental variable
# @param $1 github repo
# @param $2 pull_request number
request_review(){
 curl \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $BP_GITHUB_TOKEN" \
  https://api.github.com/repos/BoldPenguin/$1/pulls/$2/requested_reviewers \
  -d '{"reviewers":["erict11","jcoulter","neilnorthrop", "clareoneill", "nwise", "aterrype", "austin-leligdon"]}'
}

new_branch() {
  git checkout -b $1
}

rename_branch(){
  git branch -m $1 $2
}

git_cp() {
  print "Current Status of Git Repo"
  print "----------------------------------------------------------------"
  git status
  print "----------------------------------------------------------------"
  print "Adding all files"
  git add .
  print "----------------------------------------------------------------"
  git commit -m "$1"
  print "----------------------------------------------------------------"
  git push
  print "----------------------------------------------------------------"
  print "----------------------------------------------------------------"
  print "Completed Git Commit and Push"
}
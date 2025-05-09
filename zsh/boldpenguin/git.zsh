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
  -H "Authorization: Bearer $BP_REQ_REVIEW_GITHUB" \
  https://api.github.com/repos/BoldPenguin/$1/pulls/$2/requested_reviewers \
  -d '{"reviewers":["clareoneill", "aterrype", "austin-leligdon", "castriganoj", "bp-vjvans", "alexwilliams-bp"]}'
}
alias rr=request_review

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

git_compare() {
  print "Comparing $2 to $3 on the BoldPenguin $1"
  repo_url="https://github.com/BoldPenguin/"
  product=$1
  branch1=$2
  branch2=$3
  echo "${repo_url}/${product}/compare/${branch1}...${branch2}"
}

git_hard_reset() {
  GIT=$(git rev-parse --show-toplevel)
  cd $GIT/..
  rm -rf $GIT
  git clone ...
}

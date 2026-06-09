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
  -d '{"reviewers":["dillonburrows-bp", "russbogomol", "castriganoj", "saratkavila", "alexwilliams-bp"]}'
}
alias rr=request_review

# This function will fetch and display PR review comments organized by file
# Requires that have your PAT as a enviormental variable
# @param $1 github repo
# @param $2 pull_request number
get_pr_feedback(){
  local repo=$1
  local pr_number=$2

  # Validate required parameters
  if [ -z "$repo" ] || [ -z "$pr_number" ]; then
    echo "Error: Missing required parameters!"
    echo "Usage: get_pr_feedback <repo> <pr_number>"
    echo "Example: get_pr_feedback penguins 1234"
    return 1
  fi

  echo "Fetching PR feedback for PR #$pr_number in BoldPenguin/$repo..."
  echo "================================================================"

  # Test if token is set
  if [ -z "$BP_REQ_REVIEW_GITHUB" ]; then
    echo "Error: BP_REQ_REVIEW_GITHUB environment variable is not set!"
    return 1
  fi

  # GraphQL query to get all PR feedback
  local graphql_query="{\"query\": \"query { repository(name: \\\"$repo\\\", owner: \\\"BoldPenguin\\\") { pullRequest(number: $pr_number) { reviews(first: 100) { nodes { bodyText createdAt state author { login } comments(first: 100) { nodes { path position body author { login } } } } } comments(first: 100) { nodes { author { login } createdAt body } totalCount } } } }\"}"

  echo "Fetching PR data via GraphQL..."
  local temp_file=$(mktemp)
  curl -s -X POST \
    -H "Authorization: Bearer $BP_REQ_REVIEW_GITHUB" \
    -H "Content-Type: application/json" \
    -d "$graphql_query" \
    https://api.github.com/graphql > "$temp_file"

  # Check for errors
  if jq -e '.errors' "$temp_file" >/dev/null 2>&1; then
    echo "GraphQL API Error:"
    jq -r '.errors[] | "  - \(.message)"' "$temp_file"
    rm "$temp_file"
    return 1
  fi

  # Count everything directly from the file
  local review_count=$(jq '[.data.repository.pullRequest.reviews.nodes[] | select(.bodyText != null and .bodyText != "")] | length' "$temp_file" 2>/dev/null || echo "0")
  local review_comment_count=$(jq '[.data.repository.pullRequest.reviews.nodes[].comments.nodes[]] | length' "$temp_file" 2>/dev/null || echo "0")
  local pr_comment_count=$(jq '.data.repository.pullRequest.comments.nodes | length' "$temp_file" 2>/dev/null || echo "0")

  local total_count=$((review_count + review_comment_count + pr_comment_count))

  echo ""

  if [ "$total_count" -eq 0 ]; then
    echo "No feedback found for this PR."
    rm "$temp_file"
    return
  fi

  echo "Found $review_count review(s), $review_comment_count review comment(s), and $pr_comment_count conversation comment(s)"
  echo "================================================================"
  echo ""

  # Display reviews
  if [ "$review_count" -gt 0 ]; then
    echo "⭐ REVIEWS:"
    echo "================================================================"
    jq -r '
      [.data.repository.pullRequest.reviews.nodes[] | select(.bodyText != null and .bodyText != "")] |
      to_entries | map(
        "\nReview #\(.key + 1):" +
        "\n  Author: \(.value.author.login)" +
        "\n  State: \(.value.state)" +
        "\n  Date: \(.value.createdAt)" +
        "\n  Comment: \(.value.bodyText | gsub("\n"; " "))"
      ) | join("\n")
    ' "$temp_file" 2>/dev/null
    echo ""
  fi

  # Display review comments grouped by file
  if [ "$review_comment_count" -gt 0 ]; then
    echo "💬 REVIEW COMMENTS (by file):"
    echo "================================================================"

    # Flatten and group review comments by path
    jq -r '
      [.data.repository.pullRequest.reviews.nodes[].comments.nodes[]] |
      group_by(.path) |
      .[] |
      "\nFILE: \(.[0].path // "General")" +
      (to_entries | map(
        "\n  Comment #\(.key + 1):" +
        "\n    Author: \(.value.author.login)" +
        (if .value.position then "\n    Position: \(.value.position)" else "" end) +
        "\n    Comment: \(.value.body | gsub("\n"; " "))"
      ) | join("\n"))
    ' "$temp_file" 2>/dev/null
    echo ""
  fi

  # Display PR conversation comments
  if [ "$pr_comment_count" -gt 0 ]; then
    echo "💭 CONVERSATION COMMENTS:"
    echo "================================================================"
    jq -r '
      .data.repository.pullRequest.comments.nodes |
      to_entries | map(
        "\nComment #\(.key + 1):" +
        "\n  Author: \(.value.author.login)" +
        "\n  Date: \(.value.createdAt)" +
        "\n  Comment: \(.value.body | gsub("\n"; " "))"
      ) | join("\n")
    ' "$temp_file" 2>/dev/null
    echo ""
  fi

  # Clean up
  rm "$temp_file"
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

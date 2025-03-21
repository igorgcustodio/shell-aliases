# Aliases

# Command: git status
alias gs=gst

# Command: Go back to previous branch
alias pre="git checkout -";

# Command: Copy branch name

alias cb="git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n' | pbcopy"

# Command: List all branches
alias lb="git branch | cat"

# Command: List all stashes
alias gslc="git stash list | cat";

# Command: Drop the stash by id
alias gsdrop="git stash drop $1";

# Functions

# Command: Shows git log with short hash, author name, date and commit message
# Additionally, you can find for a specific commit searching by a string param
# Usage: $ glad update
glad() {
    if [ $1 ]; then
        git log --pretty=format:"%h%x09%an%x09%ad%x09%s" --no-merges -r | grep $1;
    else
        git log --pretty=format:"%h%x09%an%x09%ad%x09%s" --no-merges -r;
    fi;
}

# Command: Open the Git Open Pull Request page
pr() {
    branch=${1:-develop};
    github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's%\.git$%%' | awk '/github/'`;
    branch_name=`git symbolic-ref HEAD | cut -d"/" -f 3,4`;
    pr_url=$github_url"/compare/$branch..."$branch_name
    open $pr_url;
}

# Command: Merge the current branch with de defined branch (default branch is develop)
merge() {
    branch=${1:-develop};
    hasSavedWorking=0;

    if git stash | grep -q "Saved working"; then
        logGreenBackground "Stashing changes";
        hasSavedWorking=1;
    else
        logYellowBackground "No stash to save$NC";
    fi;

    logGreen "Checking out to $branch";
    git checkout $branch;

    logGreen "Pulling";
    git pull origin;

    logGreen "Checking out to previous branch";
    pre;

    logGreen "Merging with $branch";
    git merge --no-ff -m "merging with $branch" $branch;

    if [ $hasSavedWorking -eq 1 ]; then
        logGreenBackground "Recovering stash"
        git stash pop 0;
    fi;
}

ggc() {
    branch_name=$(git rev-parse --abbrev-ref HEAD)

    # Regex for Jira keys
    regex="([A-Z]+-\d+)"
    jira_key=$(echo "$branch_name" | grep -Eo "$regex")

    if [[ -z "$jira_key" ]]; then
        echo "❌ Error: No JIRA key found in branch name. Commit aborted."
        return 1
    fi

    commit_message="$jira_key: $1"
    
    echo "✅ Committing with message: \"$commit_message\""
    git commit -m "$commit_message" "${@:2}"
}
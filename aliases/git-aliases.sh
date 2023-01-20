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
        logGreenBackground "Salvando trabalho antes do merge";
        hasSavedWorking=1;
    else
        logYellowBackground "Sem trabalho para salvar$NC";
    fi;

    logGreen "Fazendo checkout para $branch";
    git checkout $branch;

    logGreen "Fazendo pull";
    git pull origin;

    logGreen "Retornando para a branch anterior";
    pre;

    logGreen "Fazendo merge com a $branch";
    logYellow "Atenção para possíveis conflitos";
    git merge --no-ff -m "merging with $branch" $branch;

    if [ $hasSavedWorking -eq 1 ]; then
        logGreenBackground "Retornando trabalho de stash"
        git stash pop 0;
    fi;
}

# Command: Shows the conventional commit helper
function gdoc() {
    logGreen "feat"; echo "– a new feature is introduced with the changes"
    logGreen "fix"; echo "– a bug fix has occurred"
    logGreen "chore"; echo "– changes that do not relate to a fix or feature and don't modify src or test files (for example updating dependencies)"
    logGreen "refactor"; echo "– refactored code that neither fixes a bug nor adds a feature"
    logGreen "docs"; echo "– updates to documentation such as a the README or other markdown files"
    logGreen "style"; echo "– changes that do not affect the meaning of the code, likely related to code formatting such as white-space, missing semi-colons, and so on."
    logGreen "test"; echo "– including new or correcting previous tests"
    logGreen "perf"; echo "– performance improvements"
    logGreen "ci"; echo "– continuous integration related"
    logGreen "build"; echo "– changes that affect the build system or external dependencies"
    logGreen "revert"; echo "– reverts a previous commit"
}
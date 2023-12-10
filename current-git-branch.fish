function current-git-branch
    cat .git/HEAD | cut -d/ -f3
end
# git — recipes worth memorizing

## Inspect
```sh
git status -sb              # short status + branch / ahead-behind
git log --oneline -20
git log --oneline --graph --all
git log -p path             # history with diffs for one path
git log -S'string'          # commits that added/removed a string (pickaxe)
git log --author=mike --since='2 weeks'
git blame -L 10,20 file     # who wrote these lines
git show HEAD~2:path        # a file as it was 2 commits ago
git diff --stat             # change summary
git diff main...feature     # changes on feature since it forked (3 dots)
```

## Undo / fix
```sh
git restore file            # discard unstaged changes to a file
git restore --staged file   # unstage but keep changes
git commit --amend          # fix last commit (message or add staged)
git reset --soft HEAD~1     # undo commit, keep changes staged
git reset --hard HEAD~1     # NUKE last commit + changes (careful)
git revert SHA              # safe undo: new commit reversing SHA
git reflog                  # the safety net — find 'lost' commits
git reset --hard HEAD@{2}   # jump back to a reflog state
```

## Branch / stash / rebase
```sh
git switch -c feature       # create + switch
git stash        / git stash pop
git stash -u                # include untracked files
git stash show -p           # diff of the top stash
git rebase -i HEAD~3        # squash / reorder last 3 commits
git rebase --abort          # bail out cleanly
git cherry-pick SHA
```

## Find a regression — bisect
```sh
git bisect start
git bisect bad              # current commit is broken
git bisect good v1.0        # this tag was fine
# git checks out midpoints; mark each good/bad until it names the culprit
git bisect reset            # done — return to where you were
```

## Remotes
```sh
git fetch --all --prune     # update + drop deleted remote branches
git push -u origin feature
git push --force-with-lease # safer --force: won't clobber others' pushes
```

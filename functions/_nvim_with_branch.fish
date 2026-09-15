function _nvim_with_branch --description "Append ' (branch)' to text when the given directory is a git repo on a branch"
  set -l text $argv[1]
  set -l dir $argv[2]
  set -l branch (_nvim_git_branch $dir)

  if test -n "$branch"
    echo "$text ($branch)"
  else
    echo $text
  end
end

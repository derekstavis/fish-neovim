function _nvim_git_branch --description "Print the current git branch for a directory, if it is a git repo"
  git -C $argv[1] branch --show-current 2>/dev/null
end

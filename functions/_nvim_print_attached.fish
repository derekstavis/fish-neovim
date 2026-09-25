function _nvim_print_attached --description "Print remote UIs attached to active neovim sessions"
  set -l uis (_nvim_attached_uis)

  if test (count $uis) -eq 0
    echo "No attached remote UIs found." >&2
    return 1
  end

  printf "%-9s  %-8s  %-8s  %s\n" ID SESSION SIZE CWD
  for ui in $uis
    set -l fields (string split \t -- $ui)
    set -l cwd (_nvim_session_cwd $fields[2])
    printf "%-9s  %-8s  %-8s  %s\n" $fields[1] (_nvim_session_id $fields[2]) $fields[4] (_nvim_with_branch $cwd $cwd)
  end
end

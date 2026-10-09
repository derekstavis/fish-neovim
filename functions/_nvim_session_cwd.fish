function _nvim_session_cwd --description "Ask a neovim session for its working directory"
  set -l fields (string split \t -- (_nvim_session_info $argv[1]))
  if test (count $fields) -ge 2; and test -n "$fields[2]"
    echo $fields[2]
  else
    echo "?"
  end
end

function _nvim_session_id --description "Ask a neovim session for its id (its pid)"
  set -l fields (string split \t -- (_nvim_session_info $argv[1]))
  test (count $fields) -ge 1; and echo $fields[1]
end

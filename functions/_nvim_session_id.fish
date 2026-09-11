function _nvim_session_id --description "Extract a neovim session's id (its pid) from its socket path"
  set -l match (string match -r 'nvim\.(\d+)\.0$' -- $argv[1])
  test (count $match) -ge 2; and echo $match[2]
end

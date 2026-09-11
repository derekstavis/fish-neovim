function _nvim_session_cwd --description "Ask a neovim session for its working directory via nvr"
  set -l socket $argv[1]
  set -l cwd (nvr --servername "$socket" --remote-expr "getcwd()" 2>/dev/null)
  test -z "$cwd"; and set cwd "?"
  echo $cwd
end

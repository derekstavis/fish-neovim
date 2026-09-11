function _nvim_socket_dir --description "Print the directory nvim uses for its RPC sockets"
  set -l base
  if test -n "$XDG_RUNTIME_DIR"
    set base $XDG_RUNTIME_DIR
  else if test -n "$TMPDIR"
    set base $TMPDIR
  else
    set base /tmp
  end

  set -l user "$USER"
  test -z "$user"; and set user (whoami)

  echo (string trim --right --chars=/ -- $base)"/nvim.$user"
end

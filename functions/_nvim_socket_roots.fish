function _nvim_socket_roots --description "Print candidate root directories nvim may place its RPC sockets under"
  set -l user "$USER"
  test -z "$user"; and set user (whoami)

  set -l tmpbase /tmp
  test -n "$TMPDIR"; and set tmpbase (string trim --right --chars=/ -- $TMPDIR)

  if test -n "$XDG_RUNTIME_DIR"
    set -l runtime (string trim --right --chars=/ -- $XDG_RUNTIME_DIR)
    # Linux with a runtime dir: nvim puts the socket directly here
    # (e.g. /run/user/1000/nvim.<pid>.0), with no per-user wrapper.
    echo $runtime
    # Some setups may still namespace it per-user; check for that too.
    echo "$runtime/nvim.$user"
  end

  # Fallback used when there's no XDG_RUNTIME_DIR (macOS, minimal Linux):
  # nvim creates a private per-process tmpdir nested under nvim.$user.
  echo "$tmpbase/nvim.$user"
end

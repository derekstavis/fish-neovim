function _nvim_extra_sockets --description "Print socket candidates from Neordr and \$fish_neovim_extra_sockets"
  set -l patterns

  # Neordr starts each editor as `nvim --listen <tmp>/neordr-<router pid>-<id>/nvim.sock`.
  set -l tmpbase /tmp
  test -n "$TMPDIR"; and set tmpbase (string trim --right --chars=/ -- $TMPDIR)
  set -a patterns "$tmpbase/neordr-*/nvim.sock"
  test "$tmpbase" != /tmp; and set -a patterns "/tmp/neordr-*/nvim.sock"

  # Each entry is a socket path or a glob, e.g. "/srv/editors/*.sock".
  set -a patterns $fish_neovim_extra_sockets

  for pattern in $patterns
    # Globs don't expand inside variables, and fish prints its own error for
    # a pattern without matches, so expand them in a quiet subshell.
    command fish --no-config -c "printf '%s\\n' $pattern" 2>/dev/null
  end
end

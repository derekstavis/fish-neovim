function _nvim_print_sessions --description "Print active neovim sessions with their id and working directory"
  set -l sockets (_nvim_sessions)

  if test (count $sockets) -eq 0
    echo "No active neovim sessions found." >&2
    return 1
  end

  printf "%-8s  %s\n" ID CWD
  for socket in $sockets
    set -l info (string split \t -- (_nvim_session_info $socket))
    test (count $info) -ge 2; or continue
    printf "%-8s  %s\n" $info[1] (_nvim_with_branch $info[2] $info[2])
  end
end

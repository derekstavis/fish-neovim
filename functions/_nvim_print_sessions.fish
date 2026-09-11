function _nvim_print_sessions --description "Print active neovim sessions with their id and working directory"
  set -l sockets (_nvim_sessions)

  if test (count $sockets) -eq 0
    echo "No active neovim sessions found." >&2
    return 1
  end

  printf "%-8s  %s\n" ID CWD
  for socket in $sockets
    printf "%-8s  %s\n" (_nvim_session_id $socket) (_nvim_session_cwd $socket)
  end
end

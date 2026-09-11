function _nvim_socket_for_id --description "Resolve a neovim session id (pid) to its socket path"
  set -l id $argv[1]

  for socket in (_nvim_sessions)
    if test (_nvim_session_id $socket) = "$id"
      echo $socket
      return 0
    end
  end

  return 1
end

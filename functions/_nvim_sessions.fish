function _nvim_sessions --description "List sockets of active neovim instances"
  set -l dir (_nvim_socket_dir)

  for socket in $dir/*/nvim.*.0
    test -S "$socket"; and echo $socket
  end
end

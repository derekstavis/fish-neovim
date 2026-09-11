function _nvim_sessions --description "List sockets of active neovim instances"
  set -l seen

  for dir in (_nvim_socket_roots)
    for socket in $dir/nvim.*.0 $dir/*/nvim.*.0
      test -S "$socket"; or continue
      contains -- $socket $seen; and continue
      set -a seen $socket
      echo $socket
    end
  end
end

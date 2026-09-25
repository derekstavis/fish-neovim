function _nvim_session_uis --description "List remote UIs attached to a neovim session as channel, client pid and size"
  set -l expr 'join(map(filter(nvim_list_uis(), {_, u -> nvim_get_chan_info(u.chan).stream ==# "socket"}), {_, u -> u.chan . "\t" . get(get(get(nvim_get_chan_info(u.chan), "client", {}), "attributes", {}), "pid", "") . "\t" . u.width . "x" . u.height}), "\n")'
  nvr --servername "$argv[1]" --remote-expr $expr 2>/dev/null
end

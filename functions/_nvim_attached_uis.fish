function _nvim_attached_uis --description "List remote UIs attached to active neovim sessions: id, socket, channel, size"
  for socket in (_nvim_sessions)
    for line in (_nvim_session_uis $socket)
      set -l fields (string split \t -- $line)
      test (count $fields) -ge 3; or continue

      # The client's own pid identifies it; fall back to session:channel for
      # clients that don't report one.
      set -l id $fields[2]
      test -z "$id"; and set id (_nvim_session_id $socket):$fields[1]

      printf "%s\t%s\t%s\t%s\n" $id $socket $fields[1] $fields[3]
    end
  end
end

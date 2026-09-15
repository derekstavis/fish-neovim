function __nvim_subcommand_candidates
  printf "sessions\tList active neovim sessions\n"
  printf "attach\tAttach a UI to a neovim session\n"
end

function __nvim_session_candidates
  for socket in (_nvim_sessions)
    set -l cwd (_nvim_session_cwd $socket)
    printf "%s\t%s\n" (_nvim_session_id $socket) (_nvim_with_branch (_nvim_short_path $cwd) $cwd)
  end
end

complete -c nvim -n "test -z \"\$NVIM\$NVIM_LISTEN_ADDRESS\"; and not __fish_seen_subcommand_from sessions attach" -a "(__nvim_subcommand_candidates)"
complete -c nvim -n "test -z \"\$NVIM\$NVIM_LISTEN_ADDRESS\"; and __fish_seen_subcommand_from attach" -a "(__nvim_session_candidates)" -f

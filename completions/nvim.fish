function __nvim_subcommand_candidates
  printf "sessions\tList active neovim sessions\n"
  printf "attach\tAttach a UI to a neovim session\n"
  printf "detach\tDetach a remote UI from a neovim session\n"
end

function __nvim_session_candidates
  for socket in (_nvim_sessions)
    set -l info (string split \t -- (_nvim_session_info $socket))
    test (count $info) -ge 2; or continue
    printf "%s\t%s\n" $info[1] (_nvim_with_branch (_nvim_short_path $info[2]) $info[2])
  end
end

function __nvim_attached_candidates
  for ui in (_nvim_attached_uis)
    set -l fields (string split \t -- $ui)
    set -l cwd (_nvim_session_cwd $fields[2])
    printf "%s\t%s [%s]\n" $fields[1] (_nvim_with_branch (_nvim_short_path $cwd) $cwd) $fields[4]
  end
end

complete -c nvim -n "test -z \"\$NVIM\$NVIM_LISTEN_ADDRESS\"; and not __fish_seen_subcommand_from sessions attach detach" -a "(__nvim_subcommand_candidates)"
complete -c nvim -n "test -z \"\$NVIM\$NVIM_LISTEN_ADDRESS\"; and __fish_seen_subcommand_from attach" -a "(__nvim_session_candidates)" -f
complete -c nvim -n "__fish_seen_subcommand_from detach" -a "(__nvim_attached_candidates)" -f

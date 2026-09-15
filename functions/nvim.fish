function nvim -w nvim
  switch "$argv[1]"
    case sessions
      _nvim_print_sessions
    case attach
      if test -n "$NVIM"; or test -n "$NVIM_LISTEN_ADDRESS"
        echo "nvim attach: already inside a neovim session, cannot attach to another one." >&2
        return 1
      end

      set -l sockets (_nvim_sessions)
      set -l target "$argv[2]"

      if test -z "$target"
        switch (count $sockets)
          case 0
            _nvim_print_sessions
            return 1
          case 1
            set target $sockets[1]
          case '*'
            _nvim_print_sessions
            echo "Multiple sessions found. Run 'nvim attach ' and press <Tab> to pick one, or specify an id." >&2
            return 1
        end
      end

      if string match -qr '^\d+$' -- $target
        set -l socket (_nvim_socket_for_id $target)
        if test -z "$socket"
          echo "No session with id $target" >&2
          return 1
        end
        set target $socket
      end

      if not test -S "$target"
        echo "Not a valid neovim socket: $target" >&2
        return 1
      end

      command nvim --remote-ui --server "$target"
    case '*'
      if test -z "$NVIM"; and test -z "$NVIM_LISTEN_ADDRESS"
        command nvim $argv
      else
        if test -z "$argv"
          nvr -s -cc ":enew"
        else if contains -- "--pick" $argv
          nvr --remote-send '<C-\><C-n>:set scrollback=1<CR>'
          set -l bufnr (nvr --remote-expr 'coc_explorer#select_wins#start("ABCDEFGHIJK", [], [], 1)')
          set -l file (string replace -r -- "--pick" "" $argv)
          nvr --remote-send ":wincmd $bufnr w<CR>"
          nvr --remote-send ":e $file<CR>"
        else if test -f "$argv"
          nvr -s --remote-wait-silent "$argv"
        else if set -l loc (_nvim_parse_file_line "$argv"); test (count $loc) -ge 3
          nvr -s --remote-wait-silent "+call cursor($loc[2], $loc[3])" "$loc[1]"
        else
          nvr -s -cc "$argv"
        end
      end
  end
end

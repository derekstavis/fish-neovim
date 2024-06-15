function nvim -w nvim
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
    else
      nvr -s -cc "$argv"
    end
  end
end

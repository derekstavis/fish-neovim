function clear
  nvr --remote-send '<C-\><C-n>:set scrollback=1<CR>'
  nvr --remote-send ':set scrollback=-1<CR>i'
  command reset
end

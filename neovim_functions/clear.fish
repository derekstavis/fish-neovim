function clear
  nvr --remote-send '<C-\><C-n>:set scrollback=1<CR>'
  nvr --remote-send ':set scrollback=-1<CR>i'
  printf \033\[\?1049l
  command reset
end

function _nvim_complete_tab --description "Trigger fish completion via a neovim popup instead of fish's own pager"
  set -l cmd (commandline -cp)
  set -l raw (complete -C "$cmd")

  if test (count $raw) -eq 0
    # nothing to complete
  else if test (count $raw) -eq 1
    set -l fields (string split \t -- $raw[1])
    commandline -t -- $fields[1]
  else
    set -l choice (_nvim_complete_pick $raw)
    test -n "$choice"; and commandline -t -- $choice
  end

  commandline -f repaint
end

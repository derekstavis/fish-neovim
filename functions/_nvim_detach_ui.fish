function _nvim_detach_ui --description "Detach a remote UI from a neovim session by closing its channel"
  set -l closed (nvr --servername "$argv[1]" --remote-expr "chanclose($argv[2])" 2>/dev/null)
  test "$closed" = 1
end

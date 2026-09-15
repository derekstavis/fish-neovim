function _nvim_complete_pick --description "Show completion candidates in a neovim floating-window popup; prints the chosen value"
  set -l candidates $argv
  set -l socket "$NVIM_LISTEN_ADDRESS"
  test -z "$socket"; and set socket "$NVIM"

  set -l lua_picker (string replace -a "'" "''" -- "$_nvim_pkg_dir/lua/fish_complete_picker.lua")

  set -l quoted
  for c in $candidates
    set -a quoted "'"(string replace -a "'" "''" -- $c)"'"
  end
  set -l list_literal "["(string join ", " -- $quoted)"]"

  set -l choice (nvr --servername "$socket" --remote-expr "luaeval('dofile(_A[1])(_A[2])', ['$lua_picker', $list_literal])" 2>/dev/null)

  test -n "$choice"; and echo $choice
end

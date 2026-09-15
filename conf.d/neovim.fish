set -l socket "$NVIM_LISTEN_ADDRESS"
if test -z "$socket"
  set socket "$NVIM"
end

if test -S "$socket"; and command -qs nvr
  autoload $path/neovim_functions

  if set -l hook_path $path/neovim_functions/__neovim_*_hook.fish
    for hook_path in $hook_path
      source $hook_path
    end
  end

  set -gx PATH $path/bin $PATH
  set -gx EDITOR nvim-editor
  set -gx VISUAL nvim-editor

  # Used by _nvim_complete_pick to locate the bundled Lua picker, since
  # $path (the package root) isn't otherwise visible from functions/.
  set -gx _nvim_pkg_dir $path

  # Show fish's own completions in a floating-window popup on the parent
  # neovim instance instead of fish's native pager. On by default; set
  # $fish_neovim_completion_popup to 0 to disable and keep fish's pager.
  # Bound in both the emacs-style default keymap and vi-mode's insert
  # keymap, since actual typing happens in "insert" mode under vi bindings
  # and a plain `bind` only registers in whichever mode is active when
  # this file is sourced.
  if not set -q fish_neovim_completion_popup; or test "$fish_neovim_completion_popup" != 0
    bind \t _nvim_complete_tab
    bind -M insert \t _nvim_complete_tab 2>/dev/null
  end
end

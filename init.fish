if test -n "$NVIM_LISTEN_ADDRESS"; and command -qs nvr
  autoload $path/neovim_functions

  if set -l hook_path $path/neovim_functions/__neovim_*_hook.fish
    for hook_path in $hook_path
      source $hook_path
    end
  end
end

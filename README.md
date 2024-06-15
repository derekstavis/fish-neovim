<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### neovim
>Seamless fish integration when running inside neovim

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>


## Why

Neovim built-in shell is really powerful, making neovim a great candidate
to become your main terminal multiplexer/emulator, which happens to be
my case. It isn't without it's quirks though:

1. Using the `clear` shell command resets the buffer to the top, but
   doesn't actually clear the scrollback. One could map this in neovim
   with some keybindings, but it's not as natural as just hoping `clear`
   to actually clear the scrollback.
2. Calling `nvim` will open a nested instance of neovim, instead of
   opening a new buffer inside the current instance. This is annoying and
   sometimes quitting neovim inside neovim will close the outer neovim.
3. Changing the working directory in shell does not change the working
   directory of neovim itself. This can be annoying when you're navigating
   directories and want to open a file in the current directory with `:e`.

This plugin aims to solve these problems by making shell commands more
integrated with neovim.

## Installation

You will need to [install neovim-remote](https://github.com/mhinz/neovim-remote/blob/master/INSTALLATION.md)
to use this plugin. `nvr` will be used to control the current instance of
neovim from the shell.

After you have `nvr` installed, go ahead and isntall this plugin:

```fish
$ omf install neovim
```

## Features

### `clear` will clear neovim's scrollback buffer.

It'll do that by setting the scrollback to 0 and then -1. It's not perfect
but gets the job done:

<image>


### `nvim filename` will open `filename` in the current neovim instance.

This will replace the terminal by the file, and wait for the file buffer
to be deleted before the command returns to the shell. To close the file
and return to the shell, you can use the command `:bp|bd #`, or
something like [vim-bufkill](https://github.com/qpkorr/vim-bufkill).

This makes the `git commit` workflow a breeze:

<image>

Bonus point: If you use `coc-explorer` you can call `nvim --pick filename`
to pick the window you want to open the file in. This feature is highly
experimental and may break!

<image>

### sync shell directory with current tab working directory.

This will use `:tchdir` to change the current tab's working directory
whenever the shell changes directory. This is useful if you want to open
a file in the current shell directory with `:e filename`.

<image>

# License

[MIT][mit] © [Derek Stavis][author] et [al][contributors]

[neovim-remote]:  https://github.com/mhinz/neovim-remote

[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/{{USER}}
[contributors]:   https://github.com/{{USER}}/plugin-neovim/graphs/contributors
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square

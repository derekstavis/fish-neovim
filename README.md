<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### neovim
>Seamless fish integration when running inside neovim

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>


Neovim built-in shell makes neovim a great option for a terminal
multiplexer/emulator. It isn't without it's quirks though:

1. `clear` resets the buffer to the top, but doesn't actually clear
   the scrollback. This results in high memory usage due to really
   long scrollbacks.
3. `nvim` will open a nested instance of neovim insinde a buffer,
   instead of opening a new buffer inside the current neovim instance.
   This is annoying and sometimes quitting neovim inside neovim will
   close the outer neovim.
5. Changing the working directory in shell does not change the working
   directory of neovim itself. This can be annoying when you're navigating
   directories in the shell and want to open a file in the current
   directory with `:e`.

This plugin aims to solve these problems by making shell commands more
integrated with neovim.

## Installation

You will need to [install neovim-remote](https://github.com/mhinz/neovim-remote/blob/master/INSTALLATION.md)
to use this plugin. `nvr` will be used to control the current instance of
neovim from the shell.

After you have `nvr` installed, go ahead and install this plugin:

```fish
$ omf install neovim
```

## Features

### `clear` will clear neovim's scrollback buffer.

It'll do that by setting the scrollback to 0 and then -1. It's not perfect
but gets the job done:

![clear the terminal demo](https://github.com/derekstavis/fish-neovim/assets/1611639/e9392cd5-0377-479d-94ea-b52031916e31)

### `nvim filename` will open `filename` in the current neovim instance.

This will replace the terminal by the file, and wait for the file buffer
to be deleted before the command returns to the shell. To close the file
and return to the shell, you can use the command `:bp|bd #`, or
something like [vim-bufkill](https://github.com/qpkorr/vim-bufkill).

This makes the `git commit` workflow a breeze:

![git commit demo](https://github.com/derekstavis/fish-neovim/assets/1611639/db40bfcf-ba05-4600-95d3-07f057069259)

Bonus point: If you use `coc-explorer` you can call `nvim --pick filename`
to pick the window you want to open the file in. This feature is highly
experimental and may break!

![coc-explorer integration demo](https://github.com/derekstavis/fish-neovim/assets/1611639/a2b91263-094e-44ca-8066-14412aea67e2)

### sync shell directory with current tab working directory.

This will use `:tchdir` to change the current tab's working directory
whenever the shell changes directory. This is useful if you want to open
a file in the current shell directory with `:e filename`.

![Screen Recording 2024-06-15 at 2 55 46 PM](https://github.com/derekstavis/fish-neovim/assets/1611639/7a113a00-016d-4e1e-bd86-8e4ce3f31dff)

# License

[MIT][mit] © [Derek Stavis][author] et [al][contributors]

[neovim-remote]:  https://github.com/mhinz/neovim-remote

[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/{{USER}}
[contributors]:   https://github.com/{{USER}}/plugin-neovim/graphs/contributors
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square

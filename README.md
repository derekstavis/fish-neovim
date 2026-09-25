<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### neovim
>Seamless fish integration when running inside neovim 

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>


## Features

- Clear neovim terminal scrollback with `clear`
- Change neovim tab working directory with `cd`
- Open a new split inside current instance with `nvim`
- List active neovim sessions, with their id and working directory, with `nvim sessions`
- Attach a UI to another running neovim instance with `nvim attach [id]` — press `<Tab>` for an interactive picker
- List the remote UIs attached to your sessions with `nvim detach`, and detach one from its session with `nvim detach <id>` (the id is the attached client's pid) — press `<Tab>` for the list of attached UIs
- Jump straight to a line (and column) with compiler-style references, e.g. `nvim src/main.rs:42` or `nvim src/main.rs:42:7`
- `$EDITOR`/`$VISUAL` open in the current instance's focused split — `git commit`, `git rebase -i`, `crontab -e` and friends wait for `:bd` instead of spawning a nested editor
- `<Tab>` shows fish's own completions in a floating-window popup on the parent neovim instance instead of fish's native pager — type to fuzzy-filter, arrow keys/`<C-n>`/`<C-p>`/`<Tab>` to navigate, `<Enter>` to accept, `<Esc>` to cancel

## Settings

- `$fish_neovim_completion_popup` — controls the `<Tab>` completion popup. On by default; set to `0` to disable it and keep fish's native pager instead.

## Requirements

This package requires [neovim remote][neovim-remote] to work.

## Install

```fish
$ omf install neovim
```

# License

[MIT][mit] © [Derek Stavis][author] et [al][contributors]

[neovim-remote]:  https://github.com/mhinz/neovim-remote

[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/{{USER}}
[contributors]:   https://github.com/{{USER}}/plugin-neovim/graphs/contributors
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square

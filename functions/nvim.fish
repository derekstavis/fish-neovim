function nvim -w nvim
  if test -z "$NVIM_LISTEN_ADDRESS"
    set -l tmpdir (mktemp -d -t .nvim)
    set -x NVIM $tmpdir/.socket
    set -x NVIM_LISTEN_ADDRESS $NVIM
    mkfifo $NVIM
    command nvim --listen "$NVIM"

    rm -rf $tmpdir
  else
    nvr -s -cc "leftabove split $argv"
    if test -z $argv
      nvr -cc ":enew"
    end
  end
end

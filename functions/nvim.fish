function nvim -w nvim
  if test -z "$NVIM"; and test -z "$NVIM_LISTEN_ADDRESS"
    command nvim

    rm -rf $tmpdir
  else
    if test -z "$argv"
      nvr -s -cc ":enew"
    else if test -f "$argv"
      nvr -s --remote-wait-silent "$argv"
    else
      nvr -s -cc "$argv"
    end
  end
end

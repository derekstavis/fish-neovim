function _nvim_session_info --description "Ask a neovim session for its pid and working directory in one call"
  # Prints "<pid>\t<cwd>"; prints nothing when the session doesn't answer
  # (nvr reports a dead socket on stdout, so validate the reply).
  set -l reply (nvr --servername "$argv[1]" --remote-expr 'getpid() . "\t" . getcwd()' 2>/dev/null)
  string match -qr '^\d+\t' -- "$reply"; and echo $reply
end

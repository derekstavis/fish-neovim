function _nvim_short_path --description "Print the last two path components of a directory"
  set -l parts (string split / -- $argv[1] | string match -v '')

  if test (count $parts) -eq 0
    echo /
  else if test (count $parts) -le 2
    string join / -- $parts
  else
    string join / -- $parts[-2..-1]
  end
end

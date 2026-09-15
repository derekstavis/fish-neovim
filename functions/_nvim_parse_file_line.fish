function _nvim_parse_file_line --description "Parse a compiler-style file:line[:col] reference; prints file, line, col on success"
  set -l m (string match -r '^(.+?):([0-9]+)(?::([0-9]+))?$' -- $argv[1])
  test (count $m) -ge 3; or return 1
  test -f "$m[2]"; or return 1

  echo $m[2]
  echo $m[3]
  if test (count $m) -ge 4; and test -n "$m[4]"
    echo $m[4]
  else
    echo 1
  end
end

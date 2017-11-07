function gox
  docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app golang:1.9 $argv
end

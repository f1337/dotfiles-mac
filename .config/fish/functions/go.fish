function go
  docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app golang:1.9 go $argv
end

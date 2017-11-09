function gob
  docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app -e GOOS=darwin -e GOARCH=amd64 golang:1.9 go build $argv
end

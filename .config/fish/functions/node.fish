function node
  docker run -it --rm -v "$PWD":/usr/src/app -w /usr/src/app node:6 node $argv
end

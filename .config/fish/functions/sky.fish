function sky
  docker run -it --rm -v ~/.aws:/root/.aws -v "$PWD":/usr/src/app pandastrike/panda-sky sky $argv
end

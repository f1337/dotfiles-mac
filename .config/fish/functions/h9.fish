function h9
	docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app -p 1337:1337 pandastrike/haiku9 $argv
end

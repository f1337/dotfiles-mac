function rubocop
	docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app rubocop $argv
end

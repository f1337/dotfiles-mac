function rubocop
	docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app f1337/rubocop $argv
end

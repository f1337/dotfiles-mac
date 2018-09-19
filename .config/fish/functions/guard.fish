function guard
	docker run --rm -it -v "$PWD":/usr/src/app -w /usr/src/app f1337/guard guard --no-bundler-warning --no-interactions $argv
end

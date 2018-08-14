function guard-rspec
	docker run --rm -it -v "$PWD":/usr/src/app -w /usr/src/app f1337/rspec guard --no-bundler-warning --no-interactions $argv
end

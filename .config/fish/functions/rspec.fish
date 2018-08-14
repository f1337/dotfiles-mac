function rspec
	docker run --rm -it -v "$PWD":/usr/src/app -w /usr/src/app f1337/rspec $argv
end

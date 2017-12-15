function rspec
	docker-compose run --rm -e SKIP_COVERAGE=true test bundle exec rspec $argv
end

function rspec
	docker-compose run --rm -e RSPEC_RETRY_RETRY_COUNT=0 -e SKIP_COVERAGE=true test bundle exec rspec $argv
end

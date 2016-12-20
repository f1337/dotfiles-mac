function rspec
	docker-compose run -e SKIP_COVERAGE=true rails bundle exec rspec $argv
end

function rspec
	docker-compose run -e SKIP_COVERAGE=true app bundle exec rspec $argv
end

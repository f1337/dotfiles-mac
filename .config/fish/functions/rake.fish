function rake
	docker-compose run --rm app bundle exec rake $argv
end

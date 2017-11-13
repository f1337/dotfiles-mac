function rake
	docker-compose run app bundle exec rake $argv
end

function rubocop
	docker-compose run rails bundle exec rubocop $argv
end

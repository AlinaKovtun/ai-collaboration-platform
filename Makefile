build:
	docker-compose build

start:
	docker-compose run --include-ports server

stop:
	docker-compose stop

console:
	docker-compose run server bundle exec rails console

lint:
	docker-compose run server bundle exec rubocop


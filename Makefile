include extra/.env

help:
	@echo "Main targets: build / specs / up / server / specs / shell"

# System commands

build:
	@rm -f Gemfile.lock spec/dummy/db/*.sqlite3
	@docker compose -f extra/docker-compose.yml build

db_reset:
	@docker compose -f extra/docker-compose.yml run --rm app bin/rails db:reset db:test:prepare

up: build db_reset
	@docker compose -f extra/docker-compose.yml up

shell:
	@docker compose -f extra/docker-compose.yml exec app bash

down:
	@docker compose -f extra/docker-compose.yml down --volumes --rmi local --remove-orphans

# App commands

console:
	@docker compose -f extra/docker-compose.yml exec app bin/rails console

lint:
	@docker compose -f extra/docker-compose.yml exec app bin/rubocop

server:
	@docker compose -f extra/docker-compose.yml exec app bin/rails server -b 0.0.0.0 -p ${SERVER_PORT}

specs:
	@docker compose -f extra/docker-compose.yml exec app bin/rspec --fail-fast

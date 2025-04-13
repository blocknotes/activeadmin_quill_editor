include extra/.env

help:
	@echo -e "${COMPOSE_PROJECT_NAME} - Main project commands:\n\
		make up   	# starts the dev services (optional env vars: RUBY / RAILS / ACTIVEADMIN)\n\
		make specs	# run the tests (after up)\n\
		make lint 	# run the linters (after up)\n\
		make server	# run the server (after up)\n\
		make shell	# open a shell (after up)\n\
		make down 	# cleanup (after up)\n\
	Example: RUBY=3.2 RAILS=7.1 ACTIVEADMIN=3.2.0 make up"

# System commands

build:
	@rm -f Gemfile.lock spec/dummy/db/*.sqlite3
	@docker compose -f extra/docker-compose.yml build

db_reset:
	@docker compose -f extra/docker-compose.yml run --rm app bin/rails db:create db:migrate db:test:prepare

up: build db_reset
	@docker compose -f extra/docker-compose.yml up

shell:
	@docker compose -f extra/docker-compose.yml exec app bash

down:
	@docker compose -f extra/docker-compose.yml down --volumes --rmi local --remove-orphans

# App commands

seed:
	@docker compose -f extra/docker-compose.yml exec app bin/rails db:seed

console: seed
	@docker compose -f extra/docker-compose.yml exec app bin/rails console

lint:
	@docker compose -f extra/docker-compose.yml exec app bin/rubocop

server: seed
	@docker compose -f extra/docker-compose.yml exec app bin/rails server -b 0.0.0.0 -p ${SERVER_PORT}

specs:
	@docker compose -f extra/docker-compose.yml exec app bin/rspec --fail-fast

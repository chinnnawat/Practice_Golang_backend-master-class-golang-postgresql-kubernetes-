# Create container Docker and Postgres Database
postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
createdb:
	docker exec -it postgres12 psql -U root

	CREATE ROLE postgres WITH SUPERUSER LOGIN PASSWORD 'secret';

dropdb:
	docker exec -it postgres12 dropdb simple_bank


# Migrat table
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/root?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/root?sslmode=disable" -verbose down

showlistMigration:
	ls -l db/migration

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown
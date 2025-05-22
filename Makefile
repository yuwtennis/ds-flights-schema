GOOGLE_APPLICATION_CRED_DIR := .config


define flyway-cmd
	docker run \
		 -v ~/$(GOOGLE_APPLICATION_CRED_DIR)/:/root/$(GOOGLE_APPLICATION_CRED_DIR)/ \
		 -v $$(pwd)/conf:/app/conf \
		 -v $$(pwd)/sql:/app/sql \
		 --rm \
		 -e GOOGLE_PROJECT_ID \
		 -e GOOGLE_BQ_DATASET_LOCATION \
		 flyway:latest \
		 -environment=bigquery \
		 -jarDirs=jars/bq \
		 $(1)
endef

init:
	gcloud config configurations activate dsongcp

build:
	docker build -t flyway:latest .

migrate: init
	$(call flyway-cmd, migrate)

info: init
	$(call flyway-cmd, info)

repair: init
	$(call flyway-cmd, repair)
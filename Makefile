OPERATOR_NAME=bucket-maker
REGION=asia-northeast1

GCLOUD_PROJECT := $(shell gcloud config get-value project)
GCLOUD_DOCKER_URL=gcr.io/$(GCLOUD_PROJECT)/$(OPERATOR_NAME)

build:
	gcloud builds submit \
		--project "${GCLOUD_PROJECT}" \
		--tag "$(GCLOUD_DOCKER_URL)" \
		.

deploy: build
	gcloud run deploy "$(OPERATOR_NAME)" \
		--quiet \
		--project "$(GCLOUD_PROJECT)" \
		--region "$(REGION)" \
		--image "$(GCLOUD_DOCKER_URL)" \
		--platform "managed"
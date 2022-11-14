lint:
	go mod tidy

test:
	go test ./...

install:
	go mod download

build:
	go build -o bin/server src/server.go

build-image:
	docker build --tag ${SERVICE_NAME}:latest .
	docker build --tag ${SERVICE_NAME}:${IMAGE_TAG} .

push-image-dev:
	gcloud builds submit --config=cloudbuild.yml --substitutions=_PROJECT_ID="${PROJECT_ID}",_IMAGE_NAME="${SERVICE_NAME}-${SERVICE_STAGE}",_IMAGE_TAG="${IMAGE_TAG}-dev" .

push-image-prod:
	gcloud builds submit --config=cloudbuild.yml --substitutions=_PROJECT_ID="${PROJECT_ID}",_IMAGE_NAME="${SERVICE_NAME}-${SERVICE_STAGE}",_IMAGE_TAG="${IMAGE_TAG}" .

deploy-dev-id:
	terraform apply -var stage=dev-id

deploy-dev-sg:
	terraform apply -var stage=dev-sg

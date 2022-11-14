# temporary
PROJECT_ID=hello-gcp-367807
SERVICE_NAME=order-service
SERVICE_STAGE=dev-id
IMAGE_TAG=0.0.1
GOOGLE_APPLICATION_CREDENTIALS=~/repository/hirzi.code/gcp/services/order-service/creds.json

lint:
	go mod tidy

test:
	go test ./...

install:
	go mod download

build:
	go build -o bin/server src/server.go

build-image:
	gcloud builds submit --config=cloudbuild.yml --substitutions=_PROJECT_ID="${PROJECT_ID}",_IMAGE_NAME="${SERVICE_NAME}-${SERVICE_STAGE}",_IMAGE_TAG="${IMAGE_TAG}" .

deploy-dev-id:
	terraform apply -var stage=dev-id

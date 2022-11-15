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

push-image:
	gcloud builds submit --config=cloudbuild.yml --substitutions=_PROJECT_ID="${PROJECT_ID}",_IMAGE_NAME="${SERVICE_NAME}-${SERVICE_STAGE}",_IMAGE_TAG="${IMAGE_TAG}" .

pre-deploy:
	terraform plan -no-color -input=false

deploy-dev:
	terraform apply -var stage=${SERVICE_STAGE} image_version=${IMAGE_TAG} -auto-approve -input=false

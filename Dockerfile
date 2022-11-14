# -- build stage --
FROM golang:1.16-alpine3.15 AS build

# setup
RUN apk update && apk add git --no-cache 

# set working directory
WORKDIR /app

# install dependencies
ADD go.mod go.sum ./
RUN go mod download

# build source
ADD src ./src
RUN GOOS=linux GOARCH=amd64 go build -o bin/server src/server.go

# -- run stage --
FROM alpine:3.16.2

# setup
RUN apk update && apk add ca-certificates --no-cache

# set working directory
WORKDIR /app

# copy app
COPY --from=build /app/bin/server ./server

# pre-run setup
EXPOSE 8080

# container run command
CMD ["./server"]

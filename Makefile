DEPS = $(go list -f '{{range .TestImports}}{{.}} {{end}}' ./...)
DOCKER_IMAGE = mailhog/mailhog-server
VERSION ?= latest

all: deps fmt combined

combined:
	go install .

release:
	gox -output="build/{{.Dir}}_{{.OS}}_{{.Arch}}" .

fmt:
	go fmt ./...

deps:
	go mod download
	go mod tidy

release-deps:
	go get github.com/mitchellh/gox

docker-build:
	docker build -t $(DOCKER_IMAGE):$(VERSION) .

docker-push:
	docker push $(DOCKER_IMAGE):$(VERSION)

.PHONY: all combined release fmt deps release-deps docker-build docker-push

DEPS = $(go list -f '{{range .TestImports}}{{.}} {{end}}' ./...)

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

.PHONY: all combined release fmt deps release-deps

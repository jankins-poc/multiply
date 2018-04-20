GIT_COMMIT ?= $(shell git rev-parse --short HEAD)
GOPATH ?= /go/src/github.com/jankins-poc/multiply
DOCKER_TAG = multiply:latest
DIR = /Users/ahuang/personal/jenkins-test/jenkins_home/workspace/jankins-poc_multiply_master-YSGCDK63KQVFWASKK6U75SIHZRHPEP23LK2TOAL5TFDN2Z5JBGGQ

docker:
	docker build -t $(DOCKER_TAG) .

## Run Tests
test: docker
	echo "Running Tests"
	docker run --rm -v $(DIR):$(GOPATH) -w $(GOPATH) $(DOCKER_TAG) go test

## Only run tests for PRs
pr: test

## Feature
feature: docker test
	docker run --rm -v $(DIR):$(GOPATH) -w $(GOPATH) $(DOCKER_TAG) go build -o "bin/multiply-${GIT_COMMIT}"

## Release
release: docker test
	docker run --rm -v $(DIR):$(GOPATH) -w $(GOPATH) $(DOCKER_TAG) go build -o "bin/multiply"

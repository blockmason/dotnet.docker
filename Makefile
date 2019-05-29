.PHONY: build

IMAGE_NAME=blockmason/dotnet
IMAGE_VERSION=$(shell perl -n -e'/DOTNET_VERSION="([^"]+)"/ && print "$$1";' < Dockerfile)

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
APP_NAME := $(shell echo $(ROOT_DIR) | sed 's/.*\///; s/prometheus-//')

IMAGE_TAG ?= latest
IMAGE_NAME ?= vbabichev/$(APP_NAME)

.PHONY: build
build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -f $(ROOT_DIR)/Dockerfile $(ROOT_DIR)/src/

.PHONY: deploy
deploy:
	helm upgrade -i -f values.yaml $(APP_NAME) chart/

.PHONY: help setup dependencies build bash nginx clean

NAME := tamakiii-sandbox/hello-nginx
PORT_HOST := 8080
PORT_GUEST := 80

help:
	@cat $(firstword $(MAKEFILE_LSIT))

setup: \
	dependencies \
	deps/nginx

dependencies:
	type git
	type docker

build: Dockerfile
	docker build -t $(NAME) .

bash:
	docker run -it --rm \
			-v $(PWD):/app \
			-w /app \
			$(NAME) \
			bash

nginx:
	docker run -it --rm \
			-v $(PWD):/app \
			-w /app \
			-p $(PORT_HOST):$(PORT_GUEST) \
			$(NAME) \
			nginx -g daemon off

deps/nginx: deps
	git clone --depth=1 --branch=release-1.19.4 git@github.com:nginx/nginx.git $@

deps:
	[ -d $@ ] || mkdir $@

clean:
	rm -rf deps

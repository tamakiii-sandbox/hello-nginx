.PHONY: help setup dependencies build bash clean

NAME := tamakiii-sandbox/hello-nginx

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

deps/nginx: deps
	git clone --depth=1 --branch=release-1.19.4 git@github.com:nginx/nginx.git $@

deps:
	[ -d $@ ] || mkdir $@

clean:
	rm -rf deps

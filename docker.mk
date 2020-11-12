.PHONY: help setup dependencies clean

help:
	@cat $(firstword $(MAKEFILE_LSIT))

setup: \
	dependencies \
	deps/nginx

dependencies:
	type git
	type docker

deps/nginx: deps
	git clone --depth=1 --branch=1.19.4 git@github.com:nginx/nginx.git $@

deps:
	[ -d $@ ] || mkdir $@

clean:
	rm -rf deps

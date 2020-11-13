.PHONY: help setup dependencies install clean
.PHONY: add-to-startup

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies

dependencies:
	type curl
	type nginx

install: \
	/etc/init.d/nginx \
	add-to-startup

/etc/init.d/nginx:
	curl https://www.linode.com/docs/assets/660-init-deb.sh > $@
	chmod +x /etc/init.d/nginx

add-to-startup:
	/usr/sbin/update-rc.d -f nginx defaults

clean:
	rm -rf /etc/init.d/nginx


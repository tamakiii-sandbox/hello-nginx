.PHONY: help setup dependencies build configure make make-install clean

help:
	@cat $(firstword $(MAKEFILE_LSIT))

setup: \
	dependencies

dependencies:
	id -u nginx
	id -g nginx
	test -d deps/nginx

build: \
	configure \
	make \
	make-install

# http://nginx.org/en/docs/configure.html
configure: deps/nginx
	cd $< && ./auto/configure \
		--with-debug \
		--prefix=/etc/nginx \
		--sbin-path=/usr/sbin/nginx \
		--modules-path=/usr/lib/nginx/modules \
		--conf-path=/etc/nginx/nginx.conf \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
		--user=nginx \
		--group=nginx \
		--with-compat \
		--with-file-aio \
		--with-threads \
		--with-http_addition_module \
		--with-http_auth_request_module \
		--with-http_dav_module \
		--with-http_flv_module \
		--with-http_gunzip_module \
		--with-http_gzip_static_module \
		--with-http_mp4_module \
		--with-http_random_index_module \
		--with-http_realip_module \
		--with-http_secure_link_module \
		--with-http_slice_module \
		--with-http_ssl_module \
		--with-http_stub_status_module \
		--with-http_sub_module \
		--with-http_v2_module \
		--with-mail \
		--with-mail_ssl_module \
		--with-stream \
		--with-stream_realip_module \
		--with-stream_ssl_module \
		--with-stream_ssl_preread_module \
		--with-cc-opt='-g -O2 -fdebug-prefix-map=/data/builder/debuild/nginx-1.19.4/debian/debuild-base/nginx-1.19.4=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' \
		--with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,-as-needed -pie'

make: deps/nginx
	make -C $<

make-install: deps/nginx
	make -C $< install

deps/nginx:
	echo $(error "Run `make -f docker.mk $@`")

clean:
	rm -rf deps/nginx/Makefile

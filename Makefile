PRE=dam

ALPINE_IMG=alpine-glibc
ALPINE_VER=3.4

.PHONY: alpine-glibc

all: alpine-glibc

alpine-glibc:
	docker build --tag $(PRE)/$(ALPINE_IMG):latest --tag $(PRE)/$(ALPINE_IMG):$(ALPINE_VER) $(ALPINE_IMG)-$(ALPINE_VER)
	docker save $(PRE)/$(ALPINE_IMG):latest $(PRE)/$(ALPINE_IMG):$(ALPINE_VER) > $(ALPINE_IMG)-$(ALPINE_VER).tar
	xz --compress --force --threads=0 $(ALPINE_IMG)-$(ALPINE_VER).tar

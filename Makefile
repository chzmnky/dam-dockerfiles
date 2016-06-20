PRE=dam

ALPINE_IMG=alpine-glibc
ALPINE_VER=3.4

OPENJDK8JRE_IMG=openjdk
OPENJDK8JRE_VER=8

.PHONY: alpine-glibc openjdk

all: alpine-glibc openjdk

alpine-glibc:
	docker build --tag $(PRE)/$(ALPINE_IMG):latest --tag $(PRE)/$(ALPINE_IMG):$(ALPINE_VER) $(ALPINE_IMG)-$(ALPINE_VER)
	docker save $(PRE)/$(ALPINE_IMG):latest $(PRE)/$(ALPINE_IMG):$(ALPINE_VER) > $(ALPINE_IMG)-$(ALPINE_VER).tar
	xz --compress --force --threads=0 $(ALPINE_IMG)-$(ALPINE_VER).tar

openjdk: alpine-glibc
	docker build --tag $(PRE)/$(OPENJDK8JRE_IMG):latest --tag $(PRE)/$(OPENJDK8JRE_IMG):$(OPENJDK8JRE_VER) $(OPENJDK8JRE_IMG)
	docker save $(PRE)/$(OPENJDK8JRE_IMG):latest $(PRE)/$(OPENJDK8JRE_IMG):$(OPENJDK8JRE_VER) > $(OPENJDK8JRE_IMG)-$(OPENJDK8JRE_VER).tar
	xz --compress --force --threads=0 $(OPENJDK8JRE_IMG)-$(OPENJDK8JRE_VER).tar

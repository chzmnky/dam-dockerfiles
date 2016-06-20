PRE=dam

ALPINE_IMG=alpine-glibc
ALPINE_VER=3.4

ASCIIDOCTOR_IMG=asciidoctor
ASCIIDOCTOR_VER=1.5.4

OPENJDK8JRE_IMG=openjdk
OPENJDK8JRE_VER=8

PLANTUML_IMG=plantuml
PLANTUML_VER=8043

.PHONY: alpine-glibc asciidoctor openjdk plantuml

all: alpine-glibc asciidoctor openjdk plantuml

alpine-glibc:
	docker build --tag $(PRE)/$(ALPINE_IMG):latest --tag $(PRE)/$(ALPINE_IMG):$(ALPINE_VER) $(ALPINE_IMG)-$(ALPINE_VER)
	docker save $(PRE)/$(ALPINE_IMG):latest $(PRE)/$(ALPINE_IMG):$(ALPINE_VER) > $(ALPINE_IMG)-$(ALPINE_VER).tar
	xz --compress --force --threads=0 $(ALPINE_IMG)-$(ALPINE_VER).tar

asciidoctor: openjdk
	docker build --tag $(PRE)/$(ASCIIDOCTOR_IMG):latest --tag $(PRE)/$(ASCIIDOCTOR_IMG):$(ASCIIDOCTOR_VER) $(ASCIIDOCTOR_IMG)
	docker save $(PRE)/$(ASCIIDOCTOR_IMG):latest $(PRE)/$(ASCIIDOCTOR_IMG):$(ASCIIDOCTOR_VER) > $(ASCIIDOCTOR_IMG)-$(ASCIIDOCTOR_VER).tar
	xz --compress --force --threads=0 $(ASCIIDOCTOR_IMG)-$(ASCIIDOCTOR_VER).tar

openjdk: alpine-glibc
	docker build --tag $(PRE)/$(OPENJDK8JRE_IMG):latest --tag $(PRE)/$(OPENJDK8JRE_IMG):$(OPENJDK8JRE_VER) $(OPENJDK8JRE_IMG)
	docker save $(PRE)/$(OPENJDK8JRE_IMG):latest $(PRE)/$(OPENJDK8JRE_IMG):$(OPENJDK8JRE_VER) > $(OPENJDK8JRE_IMG)-$(OPENJDK8JRE_VER).tar
	xz --compress --force --threads=0 $(OPENJDK8JRE_IMG)-$(OPENJDK8JRE_VER).tar

plantuml: openjdk
	docker build --tag $(PRE)/$(PLANTUML_IMG):latest --tag $(PRE)/$(PLANTUML_IMG):$(PLANTUML_VER) $(PLANTUML_IMG)
	docker save $(PRE)/$(PLANTUML_IMG):latest $(PRE)/$(PLANTUML_IMG):$(PLANTUML_VER) > $(PLANTUML_IMG)-$(PLANTUML_VER).tar
	xz --compress --force --threads=0 $(PLANTUML_IMG)-$(PLANTUML_VER).tar

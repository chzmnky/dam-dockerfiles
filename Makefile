PRE=dam

ALPINE_IMG=alpine-glibc
ALPINE_VER=3.4

ASCIIDOCTOR_IMG=asciidoctor
ASCIIDOCTOR_VER=1.5.4

OPENJDKJRE_IMG=openjdk-jre

OPENJDK8JRE_IMG=openjdk8-jre
OPENJDK8JRE_VER=8u92

PLANTUML_IMG=plantuml
PLANTUML_VER=8043

.PHONY: alpine-glibc asciidoctor openjdk8-jre plantuml

build: build-alpine-glibc build-asciidoctor build-openjdk8-jre build-plantuml

save: save-alpine-glibc save-asciidoctor save-openjdk8-jre save-plantuml

all: build save

alpine-glibc: build-alpine-glibc save-alpine-glibc
build-alpine-glibc:
	docker build --tag $(PRE)/$(ALPINE_IMG):latest --tag $(PRE)/$(ALPINE_IMG):$(ALPINE_VER) $(ALPINE_IMG)-$(ALPINE_VER)
save-alpine-glibc: build-alpine-glibc
	docker save $(PRE)/$(ALPINE_IMG):latest $(PRE)/$(ALPINE_IMG):$(ALPINE_VER) > $(PRE)-$(ALPINE_IMG)-$(ALPINE_VER)
	xz --compress --force --threads=0 $(PRE)-$(ALPINE_IMG)-$(ALPINE_VER)

asciidoctor: build-asciidoctor save-asciidoctor
build-asciidoctor: build-openjdk8-jre
	docker build --tag $(PRE)/$(ASCIIDOCTOR_IMG):latest --tag $(PRE)/$(ASCIIDOCTOR_IMG):$(ASCIIDOCTOR_VER) $(ASCIIDOCTOR_IMG)
save-asciidoctor: build-asciidoctor
	docker save $(PRE)/$(ASCIIDOCTOR_IMG):latest $(PRE)/$(ASCIIDOCTOR_IMG):$(ASCIIDOCTOR_VER) > $(PRE)-$(ASCIIDOCTOR_IMG)-$(ASCIIDOCTOR_VER)
	xz --compress --force --threads=0 $(PRE)-$(ASCIIDOCTOR_IMG)-$(ASCIIDOCTOR_VER)

openjdk8-jre: build-openjdk8-jre save-openjdk8-jre
build-openjdk8-jre: build-alpine-glibc
	docker build --tag $(PRE)/$(OPENJDKJRE_IMG):latest --tag $(PRE)/$(OPENJDKJRE_IMG):$(OPENJDK8JRE_VER) $(OPENJDK8JRE_IMG)
save-openjdk8-jre: build-openjdk8-jre
	docker save $(PRE)/$(OPENJDKJRE_IMG):latest $(PRE)/$(OPENJDKJRE_IMG):$(OPENJDK8JRE_VER) > $(PRE)-$(OPENJDKJRE_IMG)-$(OPENJDK8JRE_VER)
	xz --compress --force --threads=0 $(PRE)-$(OPENJDKJRE_IMG)-$(OPENJDK8JRE_VER)

plantuml: build-plantuml save-plantuml
build-plantuml: build-openjdk8-jre
	docker build --tag $(PRE)/$(PLANTUML_IMG):latest --tag $(PRE)/$(PLANTUML_IMG):$(PLANTUML_VER) $(PLANTUML_IMG)
save-plantuml: build-plantuml
	docker save $(PRE)/$(PLANTUML_IMG):latest $(PRE)/$(PLANTUML_IMG):$(PLANTUML_VER) > $(PRE)-$(PLANTUML_IMG)-$(PLANTUML_VER)
	xz --compress --force --threads=0 $(PRE)-$(PLANTUML_IMG)-$(PLANTUML_VER)

FROM dam/java:8

ENV PLANTUML_VERSION=8043

RUN apk add --no-cache --virtual=build-dependencies ca-certificates graphviz openssl && \
    wget -O plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download" && \
    apk del --no-cache build-dependencies ca-certificates openssl

ENTRYPOINT ["java", "-Djava.awt.headless=true", "-jar", "plantuml.jar", "-p"]

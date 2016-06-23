FROM dam/openjdk-jre:8u92

# RUN apk add --no-cache asciidoctor

ENV PATH /fopub/bin:$PATH

RUN apk add --no-cache \
    build-base \
    graphviz \
    pango \
    python \
    py-cairo \
    py-gtk \
    py-pip \
    ruby \
    ruby-dev \
    ruby-irb \
  && pip install --upgrade pip \
  && pip install \
    shaape \
  && gem install --no-ri --no-rdoc \
    asciidoctor-diagram \
    asciidoctor-pdf --pre \
    coderay \
    json \
    pygments.rb \
    thread_safe \
  && apk del --no-cache \
    build-base \
    ruby-dev

FROM node:latest
MAINTAINER Tony Motakis <tvelocity@gmail.com>

ENV ETHERPAD_VERSION 1.7.5
ENV NODE_ENV production

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl unzip mysql-client postgresql-client && \
    rm -r /var/lib/apt/lists/*

WORKDIR /opt/

RUN curl -SL \
    https://github.com/ether/etherpad-lite/archive/${ETHERPAD_VERSION}.zip \
    > etherpad.zip && unzip etherpad && rm etherpad.zip && \
    mv etherpad-lite-${ETHERPAD_VERSION} etherpad-lite

WORKDIR etherpad-lite

RUN bin/installDeps.sh && rm settings.json
COPY entrypoint.sh /entrypoint.sh

RUN sed -i 's/^node/exec\ node/' bin/run.sh

# OpenShift runs containers as non-root
RUN chmod g+rwX,o+rwX -R .
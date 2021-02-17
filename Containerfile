FROM node:alpine

ENV UPDATED=2020-10-05
ENV TIDDLYWIKI_VERSION=5.1.22

RUN apk add --no-cache tini git \
    && npm install -g tiddlywiki@${TIDDLYWIKI_VERSION} \
    && git clone https://github.com/linonetwo/tiddlywiki-plugins.git /usr/local/lib/linonetwo \
    && ln -s /usr/local/lib/linonetwo/plugins/linonetwo /usr/local/lib/node_modules/tiddlywiki/plugins/

EXPOSE 8080

VOLUME /tiddlywiki
WORKDIR /tiddlywiki/data

USER 1000:1000

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["tiddlywiki", "+plugins/tiddlywiki/+plugins/tiddlywiki/filesystem", "+plugins/tiddlywiki/tiddlyweb", "+plugins/linonetwo/watch-fs", "--listen", "host=0.0.0.0"]

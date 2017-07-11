FROM debian:8
MAINTAINER Vladimir Kozlovski <vladimir@kozlovskilab.com>
ENV DEBIAN_FRONTEND noninteractive

ENV BUILD_DEPENDENCIES curl ca-certificates

RUN apt-get update && \
    apt-get install -y --no-install-recommends $BUILD_DEPENDENCIES \
      numactl \
      libssl1.0.0 && \
    rm -rf /var/lib/apt/lists/*


# grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" && \
        curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" && \
        gpg --verify /usr/local/bin/gosu.asc && \
        rm /usr/local/bin/gosu.asc && \
        chmod +x /usr/local/bin/gosu


ENV MONGO_VERSION 3.4.4
ENV MONGO_DOWNLOAD_URL https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian71-$MONGO_VERSION.tgz
ENV MONGO_RELEASE_FINGERPRINT 0C49F3730359A14518585931BC711F9BA15703C6

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mongodb && \
    useradd -r -g mongodb mongodb

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys $MONGO_RELEASE_FINGERPRINT
RUN curl -SL "$MONGO_DOWNLOAD_URL" -o mongo.tgz && \
        curl -SL "$MONGO_DOWNLOAD_URL.sig" -o mongo.tgz.sig && \
        gpg --verify mongo.tgz.sig && \
        tar -xvf mongo.tgz -C /usr/local --strip-components=1 && \
        rm mongo.tgz* && \
        apt-get purge -y --auto-remove $BUILD_DEPENDENCIES


RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db
VOLUME /data/db

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
     build-essential \
     git \
     mongodb-server \
     ruby-dev \
     ruby-full \
    && rm -rf /var/lib/apt/lists/*
RUN gem install bundler
RUN git clone https://github.com/Artemmkin/reddit.git

COPY mongod.conf /etc/mongod.conf
COPY db_config /app/db_config
COPY start.sh /start.sh

WORKDIR /reddit
RUN bundle install
RUN mkdir -p /data/db
RUN chmod 0777 /start.sh

CMD ["/start.sh"]

FROM python:2.7.10

# Set up sentry user
RUN groupadd sentry && useradd --create-home --home-dir /home/sentry -g sentry sentry
WORKDIR /home/sentry

# Sentry dependencies
RUN pip install \
    psycopg2 \
    mysql-python \
    supervisor \
    # Slack integration
    https://github.com/getsentry/sentry-slack/archive/master.zip \
    # Memcached
    python-memcached \
    # Redis
    redis \
    hiredis \
    nydus

# Sentry
ENV SENTRY_VERSION 7.7.4
RUN pip install sentry==$SENTRY_VERSION

# Set up directories
RUN mkdir -p /home/sentry/.sentry \
    && chown -R sentry:sentry /home/sentry/.sentry \
    && chown -R sentry /var/log

# Base configuration
COPY sentry.conf.py /home/sentry/.sentry/sentry.conf.py

#USER sentry
EXPOSE 9000/tcp 9001/udp

# Making sentry commands easier to run
RUN ln -s /home/sentry/.sentry /root

# Start Sentry
CMD sentry --config=/home/sentry/.sentry/sentry.conf.py start

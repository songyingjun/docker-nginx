FROM nginx:1.14.0
MAINTAINER Joye Song <joyesong@qq.com>

# Remove sym links from nginx image
RUN rm /var/log/nginx/access.log
RUN rm /var/log/nginx/error.log
# Install logrotate
RUN apt-get update && \
  apt-get install -y cron && \
  apt-get -y install logrotate && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

ADD nginx.logrotate /etc/logrotate.d/nginx
RUN mv /etc/cron.daily/logrotate /usr/local/bin/logrotate
RUN mv crontabs /var/spool/cron/crontabs/root
# Start nginx and cron as a service
CMD service cron start && nginx -g 'daemon off;'

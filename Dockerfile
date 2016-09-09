FROM ubuntu:14.04

MAINTAINER Alex Savchenko <alexey.savchenko@forma-pro.com>

RUN apt-get update -y && echo "2" | apt-get install -y --no-install-recommends proftpd && apt-get clean
RUN groupadd ftpaccess; \
    chown root /home; \
    echo "2" | apt-get install -y --no-install-recommends proftpd; \
    sed -i 's/# DefaultRoot.*/DefaultRoot ~/' /etc/proftpd/proftpd.conf;    

EXPOSE 20 21 22
COPY start-ftp.sh /tmp

ENTRYPOINT ["/tmp/start-ftp.sh"]

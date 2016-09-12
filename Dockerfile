FROM ubuntu:14.04

MAINTAINER Alex Savchenko <alexey.savchenko@forma-pro.com>

RUN apt-get update -y && echo "2" | apt-get install -y --no-install-recommends proftpd openssh-server && apt-get clean
RUN groupadd ftpaccess; \
    chown root /home; \
    chmod 755 /home; \
    echo "2" | apt-get install -y --no-install-recommends proftpd; \
    sed -i 's/# DefaultRoot.*/DefaultRoot ~/' /etc/proftpd/proftpd.conf; \
    sed -i 's/.*Subsystem.*/Subsystem sftp internal-sftp/' /etc/ssh/sshd_config; \
    sed -i 's/.*UsePAM yes.*/#UsePAM yes/' /etc/ssh/sshd_config; \
    echo "Match Group ftpaccess" | tee -a /etc/ssh/sshd_config; \
    echo "\tX11Forwarding no" | tee -a /etc/ssh/sshd_config; \
    echo "\tAllowTcpForwarding no" | tee -a /etc/ssh/sshd_config; \
    echo "\tAllowAgentForwarding no" | tee -a /etc/ssh/sshd_config; \
    echo "\tForceCommand internal-sftp" | tee -a /etc/ssh/sshd_config;
    
EXPOSE 20 21 22
COPY start-ftp.sh /tmp

ENTRYPOINT ["/tmp/start-ftp.sh"]

FROM debian:latest

RUN apt-get update && apt-get install -y openssh-server iputils-ping fail2ban
RUN mkdir /var/run/sshd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Create entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 2222

ENTRYPOINT ["/entrypoint.sh"]

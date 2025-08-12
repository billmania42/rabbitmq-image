FROM redhat/ubi8:latest

ADD rabbit.repo /etc/yum.repos.d/rabbit.repo

RUN yum repolist && \
    yum install --setopt=tsflags=nodocs -y libtool erlang wget && \
    yum update --setopt=tsflags=nodocs -y && \
    yum clean all 

RUN mkdir -p /opt && \ 
    wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.23/rabbitmq-server-generic-unix-3.8.23.tar.xz -O /opt/rabbitmq-server-generic-unix-3.8.23.tar.xz  && \
    ls -l /opt/rabbitmq-server-generic-unix-3.8.23.tar.xz  && \
    tar xJf /opt/rabbitmq-server-generic-unix-3.8.23.tar.xz -C /opt && \
    mv /opt/rabbitmq_server-3.8.23 /opt/rabbitmq && \
    mkdir -p /opt/rabbitmq/conf /opt/rabbitmq/defs && \
    chgrp -R 0 /opt/rabbitmq && \
    chmod -R g=u /etc/passwd /opt/rabbitmq/ && \
    rm -f /opt/rabbitmq-server-generic-unix-3.8.23.tar.xz
    

ENV RABBITMQ_HOME=/opt/rabbitmq \
    PATH=/opt/rabbitmq/sbin${PATH:+:${PATH}} \
    HOME=/opt/rabbitmq
    
EXPOSE 15672
EXPOSE 15692
EXPOSE 5672

ENV NAME RabbitMQ

ADD start.sh /start.sh

USER 1001

CMD ["/usr/bin/bash", "start.sh"]

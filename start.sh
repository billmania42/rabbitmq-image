#!/bin/bash
echo "--------------------------------------------------Adding rabbitmq User---------------------------------------------"

echo "${USER_NAME:-rabbitmq}:x:$(id -u):0:${USER_NAME:-rabbitmq} user:${RABBITMQ_HOME}:/sbin/nologin" >> /etc/passwd
echo -------------------------------------- Starting RabbitMQ Server ----------------------------------------------
rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_prometheus
sleep 10
rabbitmq-server --detached

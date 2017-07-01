RABBITMQ_NODE_PORT=5801 RABBITMQ_NODENAME=rabbit_1 rabbitmq-server -detached
 

RABBITMQ_NODE_PORT=5802 RABBITMQ_NODENAME=rabbit_2 rabbitmq-server -detached
rabbitmqctl -n rabbit_2@`hostname` stop_app
rabbitmqctl -n rabbit_2@`hostname` reset
rabbitmqctl -n rabbit_2@`hostname` join_cluster rabbit_1@`hostname`
rabbitmqctl -n rabbit_2@`hostname` start_app

RABBITMQ_NODE_PORT=5803 RABBITMQ_NODENAME=rabbit_3 rabbitmq-server -detached
rabbitmqctl -n rabbit_3@`hostname` stop_app
rabbitmqctl -n rabbit_3@`hostname` reset
rabbitmqctl -n rabbit_3@`hostname` join_cluster rabbit_1@`hostname` --ram
rabbitmqctl -n rabbit_3@`hostname` start_app

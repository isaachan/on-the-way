RABBITMQ_NODE_PORT=5672 RABBITMQ_NODENAME=rabbit rabbitmq-server -detached

RABBITMQ_NODE_PORT=5801 RABBITMQ_NODENAME=rabbit_a rabbitmq-server -detached
rabbitmqctl -n rabbit_a@`hostname` stop_app
rabbitmqctl -n rabbit_a@`hostname` reset
rabbitmqctl -n rabbit_a@`hostname` join_cluster rabbit@`hostname`
rabbitmqctl -n rabbit_a@`hostname` start_app
 
RABBITMQ_NODE_PORT=5802 RABBITMQ_NODENAME=rabbit_b rabbitmq-server -detached
rabbitmqctl -n rabbit_b@`hostname` stop_app
rabbitmqctl -n rabbit_b@`hostname` reset
rabbitmqctl -n rabbit_b@`hostname` join_cluster rabbit@`hostname`
rabbitmqctl -n rabbit_b@`hostname` start_app

RABBITMQ_NODE_PORT=5803 RABBITMQ_NODENAME=rabbit_c rabbitmq-server -detached
rabbitmqctl -n rabbit_c@`hostname` stop_app
rabbitmqctl -n rabbit_c@`hostname` reset
rabbitmqctl -n rabbit_c@`hostname` join_cluster rabbit@`hostname`
rabbitmqctl -n rabbit_c@`hostname` start_app

RABBITMQ_NODE_PORT=5804 RABBITMQ_NODENAME=rabbit_d rabbitmq-server -detached
rabbitmqctl -n rabbit_d@`hostname` stop_app
rabbitmqctl -n rabbit_d@`hostname` reset
rabbitmqctl -n rabbit_d@`hostname` join_cluster rabbit@`hostname` --ram
rabbitmqctl -n rabbit_d@`hostname` start_app

rabbitmqctl -n rabbit add_user cluster_user clusterme
rabbitmqctl -n rabbit set_permissions cluster_user ".*" ".*" ".*"

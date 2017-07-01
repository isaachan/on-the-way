import pika

creds_broker = pika.PlainCredentials("cluster_user", "clusterme")
conn_params = pika.ConnectionParameters("localhost",
                                        virtual_host = "/",
                                        credentials = creds_broker)
conn_broker = pika.BlockingConnection(conn_params)
channel = conn_broker.channel()

'''
The use of queue arguments to declare a queue as HA dates from RabbitMQ 
2.x. In 3.x we changed this to use policies as you've already seen - 
since applications should not have to know about whether their queues 
are HA.

So use rabbitmqctl set_policy (or the management plugin).
 
> rabbitmqctl set_policy ha-fed "cluster_queue" '{"ha-mode":"all"}' --priority 1 --apply-to queues
'''

channel.queue_declare(queue = "cluster_queue")


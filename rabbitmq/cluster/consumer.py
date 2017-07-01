import pika

creds_broker = pika.PlainCredentials("cluster_user", "clusterme")
conn_params = pika.ConnectionParameters("localhost",
                                        virtual_host = "/",
                                        credentials = creds_broker)
conn_broker = pika.BlockingConnection(conn_params)
channel = conn_broker.channel()

queue_args = {"x-ha-proxy": "all"}
channel.queue_declare(queue = "cluster_queue", arguments = queue_args)


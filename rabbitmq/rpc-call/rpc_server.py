import json, pika

creds_broker = pika.PlainCredentials("rpc_user", "rpcme")
conn_params = pika.ConnectionParameters("localhost",
                                        virtual_host = "/",
                                        credentials = creds_broker)
conn_broker = pika.BlockingConnection(conn_params)
channel = conn_broker.channel()

channel.exchange_declare(exchange = "rpc",
                         exchange_type = "direct",
                         auto_delete = False)

channel.queue_declare(queue = "ping",
                      auto_delete = False)

channel.queue_bind(queue = "ping",
                   exchange = "rpc",
                   routing_key = "ping")

def api_ping(channel, method, header, body):
    channel.basic_ack(delivery_tag = method.delivery_tag)
    print(body.decode("utf-8"))
    msg_dict = json.loads(body.decode("utf-8"))
    print("received API call ... replying ...")
    channel.basic_publish(body = "Pong" + str(msg_dict["time"]),
                          exchange = "",
                          routing_key = header.reply_to)

channel.basic_consume(api_ping,
                      queue = "ping",
                      consumer_tag = "ping")

print("Waiting for RPC calls")
channel.start_consuming()

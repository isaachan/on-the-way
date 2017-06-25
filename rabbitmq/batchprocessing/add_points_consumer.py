import json, pika

def add_points(channel, method, header, body):
    print("recived message: " + str(body))
    channel.basic_ack(delivery_tag = method.delivery_tag)    

creds_broker = pika.PlainCredentials("batchp", "batchp")
conn_params = pika.ConnectionParameters("localhost",
                                        virtual_host = "/",
                                        credentials = creds_broker)
conn_broker = pika.BlockingConnection(conn_params)
channel = conn_broker.channel()

channel.exchange_declare(exchange = "images",
                         exchange_type = "fanout",
                         auto_delete = False)
    
channel.queue_declare(queue = "add_points", auto_delete = False)
channel.queue_bind(queue = "add_points",
                   exchange = "images")

channel.basic_consume(add_points,
                      queue = "add_points",
                      no_ack = False,
                      consumer_tag = "add_points")

print("ready for adding points for images uploading!")
channel.start_consuming()

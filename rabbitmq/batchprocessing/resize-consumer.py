import json, pika

def resize(channel, method, header, body):
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
    
channel.queue_declare(queue = "resize", auto_delete = False)
channel.queue_bind(queue = "resize",
                   exchange = "images")

channel.basic_consume(resize,
                      queue = "resize",
                      no_ack = False,
                      consumer_tag = "resize")

print("ready for resizing for images uploading!")
channel.start_consuming()

import json, pika
from optparse import OptionParser

opt_parser = OptionParser()
opt_parser.add_option("-i",
                      "--image-id",
                      dest = "image_id")
opt_parser.add_option("-u",
                      "--user-id",
                      dest = "user_id")
opt_parser.add_option("-p",
                      "--image-path",
                      dest = "image_path")

args = opt_parser.parse_args()[0]
creds_broker = pika.PlainCredentials("batchp", "batchp")
conn_params = pika.ConnectionParameters("localhost",
                                        virtual_host = "/",
                                        credentials = creds_broker)

conn_broker = pika.BlockingConnection(conn_params)
channel = conn_broker.channel()

msg = json.dumps({"image_id": args.image_id, "user_id": args.user_id, "image_path": args.image_path})
msg_props = pika.BasicProperties()
msg_props.content_type = "application/json"
msg_props.durable = False

channel.basic_publish(body = msg, exchange = "images", properties = msg_props, routing_key = "*")

print("send message %s. to '/'." % str(msg))

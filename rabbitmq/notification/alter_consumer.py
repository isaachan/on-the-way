import json, smtplib, pika

if __name__ = "main":
    AMQP_SERVER = "locahost"
    AMQP_USER = "alter_user"
    AMQP_PASS = "alterme"
    AMQP_VHOST = "/*"
    AMQP_EXCHANGE = "alters"


    creds_broker = pika.Plaincredentials(AMQP_USER, AMQP_PASS)
    conn_params = pika.ConnectionParameters(AMQP_SERVER,
                                            virtual_host = AMQP_VHOST,
                                            credentials = creds_broker)
    conn_broker = pika.BlockingConnection(conn_params)
    channel = conn_broker.channel()

    channel.exchange_declare(exhange = AMQP_EXCHANGE,
                             type = "topic",
                             auto_delete = False)
    
    channel.queue_declare(queue = "citical", auto_delete = False)
    channel.queue_bind(queue = "critical",
                       exchange = AMQP_EXCHANGE,
                       routing_key = "critical.*")

    channel.queue_declare(queue = "rate_limit", auto_delete = False)
    channel.queue_bind(queue = "rate_limit",
                       exhange = AMQP_EXCHANGE,
                       routing_key = "*.rate_limit")

    channel.basic_consume(critical_notify,
                          queue = "critical",
                          no_ack = False,
                          consumer_tag = "critical")
    channel.basic_consume(rate_limit_notify,
                          queue = "rate_limit",
                          no_ack = False,
                          consumer_tag = "rate_limit")

    print("ready for alerts!")
    channel.start_consuming()

def critical_notify(channel, method, header, body):
    EMAIL_RECIPS = ["ops.team@ourcompany.com"]
    message = json.loads(body)
    print("Send alter via email. Alter Text: %s " + \
          "Recipients: %s") % (str(message), str(EMAIL_RECIPS))
    channel.basic_ack(delivery_tag = method.delivery_tag)



def rate_limit_notify(channel, method, header, body):
    EMAIL_RECIPS = ["api.team@ourcompany.com"]
    message = json.loads(body)
    print("Send alter via email. Alter Text: %s " + \
          "Recipients: %s") % (str(message), str(EMAIL_RECIPS))
    channel.basic_ack(delivery_tag = method.delivery_tag)
    

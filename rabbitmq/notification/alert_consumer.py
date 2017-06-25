import json, smtplib, pika

def critical_notify(channel, method, header, body):
    print("recived critical message: " + str(body))
    channel.basic_ack(delivery_tag = method.delivery_tag)

def rate_limit_notify(channel, method, header, body):
    print("recived rate_limit message: " + str(body))
    channel.basic_ack(delivery_tag = method.delivery_tag)
    
def run():
    AMQP_SERVER = "localhost"
    AMQP_USER = "alert_user"
    AMQP_PASS = "alertme"
    AMQP_VHOST = "/"
    AMQP_EXCHANGE = "alerts"

    creds_broker = pika.PlainCredentials(AMQP_USER, AMQP_PASS)
    conn_params = pika.ConnectionParameters(AMQP_SERVER,
                                            virtual_host = AMQP_VHOST,
                                            credentials = creds_broker)
    conn_broker = pika.BlockingConnection(conn_params)
    channel = conn_broker.channel()

    channel.exchange_declare(exchange = AMQP_EXCHANGE,
                             exchange_type = "topic",
                             auto_delete = False)
    
    channel.queue_declare(queue = "critical", auto_delete = False)
    channel.queue_bind(queue = "critical",
                       exchange = AMQP_EXCHANGE,
                       routing_key = "critical.*")

    channel.queue_declare(queue = "rate_limit", auto_delete = False)
    channel.queue_bind(queue = "rate_limit",
                       exchange = AMQP_EXCHANGE,
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

run()

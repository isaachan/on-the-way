rabbitmqctl add_user alert_user alertme
rabbitmqctl set_permissions alert_user ".*" ".*" ".*"

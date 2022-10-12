channel = RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue('auth', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  user_id = nil
  payload = JSON(payload)
  token = JwtEncoder.decode(payload)

  unless token.nil?
    result = Auth::FetchUserService.call(token['uuid'])
    user_id = result.user.id if result.success?
  end
ensure
  publish_payload = { user_id: user_id }.to_json
  exchange.publish(
    publish_payload,
    routing_key: properties.reply_to,
    correlation_id: properties.correlation_id
  )
  channel.ack(delivery_info.delivery_tag)
end

module RouteHelpers
  def app
    described_class
  end

  def response_body
    JSON(last_response.body)
  end

  def auth_token(user)
    session = user.add_session({})
    token = JwtEncoder.encode(uuid: session.uuid)
    "Bearer #{token}"
  end
end

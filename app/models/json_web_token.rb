class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload.merge(exp: expiration), Rails.application.secrets.secret_key_base, 'HS512')
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS512').first
  end

  def self.expiration
    30.days.from_now.to_i
  end
end

#his class will encapsulate the JWT token encoding and decoding logic，作JWT的加密與解密
class JsonWebToken
  def self.encode(payload)
    payload.merge!(exp: (Time.now.to_i + 3600)) # 添加過期時間為一小時
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
  rescue
    nil
  end
end
require "crypto/bcrypt/base64"

class Session < Amatista::Model
  def self.create(email, raw_password)
    password = Crypto::Bcrypt.new.digest(raw_password)
    result = DB.exec({Int32, String}, 
                     "select id, email from users where email = $1 and password = $2",
                    [email, password])
  end
end

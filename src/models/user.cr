require "secure_random"
require "crypto/bcrypt"

class User < Amatista::Model
  def self.create(name, email, raw_password, raw_password_confirmation)
    if raw_password == raw_password_confirmation
      password = Crypto::Bcrypt.digest(raw_password, 9)
      connect {|db| db.exec("insert into users(name, email, password) values ($1, $2, $3)", 
                            [name, email, password]) }
    else
      raise "password and password confirmation do not match"
    end
  end

  def self.login(email : String, password : String) : Hash(String, String) | Nil
    user = [] of Hash(String, String)
    connect {|db| user = db.exec({String, String, String, String}, 
                                 "select id::varchar, name, email, password from users where email = $1", 
                                 [email]).to_hash.first }
    if user.is_a?(Hash(String, String))
      verified = Crypto::Bcrypt.verify(password, user["password"])
      user if verified
    end
  end

  def self.find_by_email(email)
    user = [] of Hash(String, String)
    connect {|db| user = db.exec("select id, name, email, password from users where email = $1 limit 1", 
                                 [email]).to_hash }
    user[0] if user.length > 0
  end
end

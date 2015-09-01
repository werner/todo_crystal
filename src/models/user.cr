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

  def self.login(email, password)
    user = [] of Hash(String, String)
    connect {|db| user = db.exec({Int32, String, String, String}, 
                                 "select id, name, email, password from users where email = $1", 
                                 [email]).rows }

    if user
      verified = Crypto::Bcrypt.verify(password, user[0][3])
      user if verified
    end
  end

end

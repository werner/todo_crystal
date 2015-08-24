require "secure_random"
require "crypto/bcrypt"

class User < Amatista::Model
  def self.create(name, email, raw_password, raw_password_confirmation)
    if raw_password == raw_password_confirmation
      password = Crypto::Bcrypt.digest(raw_password)
      connect {|db| db.exec("insert into users(name, email, password) values ($1, $2, $3)", 
                            [name, email, password]) }
    else
      raise "password and password confirmation do not match"
    end
  end
end

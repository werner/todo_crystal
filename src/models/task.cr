class Task < Amatista::Model
  property connection
  
  def self.all
    records = [] of String
    connect {|db| records = db.exec("select * from tasks order by done").rows }
    records
  end

  def self.all_by_user(user_id)
    records = [] of String
    connect {|db| records = db.exec("select * from tasks where user_id = $1 order by done", [user_id]).rows }
    records
  end

  def self.create(description, user_id)
    connect {|db| db.exec("insert into tasks(description, user_id, done) values ($1, $2, false)", [description, user_id]) }
  end

  def self.find(id)
    record = [] of String
    connect {|db| record = db.exec("select * from tasks where id = $1 limit 1", [id]).to_hash }
    record.first
  end

  def self.update(description, id)
    connect {|db| db.exec("update tasks set description = $1 where id = $2", [description, id]) }
  end

  def self.check(done, id)
    connect {|db| db.exec("update tasks set done = $1 where id = $2", [done, id]) }
  end

  def self.delete(id)
    connect {|db| db.exec("delete from tasks where id = $1", [id]) }
  end
end

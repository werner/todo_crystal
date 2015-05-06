class PGTask
  property connection
  
  def initialize(@connection)
    @db = PG.connect(@connection)
  end

  def all
    @db.exec("select * from tasks")
  end

  def create(description)
    @db.exec("insert into tasks(description, done) values ('#{description}', 0)")
  end

  def find(id)
    @db.exec("select * from tasks where id = ? limit 1", id)
  end

  def update(description, id)
    @db.exec("update tasks set description = ? where id = ?", description, id)
  end

  def check(done, id)
    @db.exec("update tasks set done = ? where id = ?", done, id)
  end

  def delete(id)
   @db.exec("delete from tasks where id = ?", id)
  end
end

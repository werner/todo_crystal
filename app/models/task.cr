class Task
  property connection
  
  def initialize(@connection)
    @db = PG.connect(@connection)
  end

  def all
    @db.exec("select * from tasks").rows
  end

  def create(description)
    p description
    @db.exec("insert into tasks(description, done) values ($1, false)", [description])
  end

  def find(id)
    @db.exec("select * from tasks where id = $1 limit 1", [id]).rows
  end

  def update(description, id)
    @db.exec("update tasks set description = $1 where id = $2", [description, id])
  end

  def check(done, id)
    @db.exec("update tasks set done = $1 where id = $2", [done, id])
  end

  def delete(id)
   @db.exec("delete from tasks where id = $1", [id])
  end
end

class SQLiteTask
  property db_filename
  
  def initialize(@db_filename)
  end

  def all
    db = SQLite3::Database.new( @db_filename ) 
    tasks = db.execute("select * from tasks")
    db.close
    tasks
  end

  def create(description)
    db = SQLite3::Database.new( @db_filename ) 
    db.execute "insert into tasks(description, done) values ('#{description}', 0)"
    db.close
  end

  def find(id)
    db = SQLite3::Database.new( @db_filename )
    task = db.execute("select * from tasks where id = ? limit 1", id)
    db.close
  end

  def update(description, id)
    db = SQLite3::Database.new( @db_filename ) 
    db.execute "update tasks set description = ? where id = ?", description, id
    db.close
  end

  def check(done, id)
    db = SQLite3::Database.new( @db_filename ) 
    db.execute "update tasks set done = ? where id = ?", done, id
    db.close
  end

  def delete(id)
   db = SQLite3::Database.new( @db_filename ) 
   db.execute "delete from tasks where id = ?", id
   db.close
  end

end

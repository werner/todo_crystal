require "sqlite3"
def create_table(db, table_name)
  if db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='#{table_name}';").empty?
    yield db
  end
end


db_filename = "data.sqlite3"
db = SQLite3::Database.new( db_filename ) 
create_table(db, "items") do |db|
  db.execute("create table items(id int primary key not null, description text not null, done boolean)")
end

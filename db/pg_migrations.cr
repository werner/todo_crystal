require "pg"

def create_table(db, table_name)
  if db.exec("SELECT * FROM pg_catalog.pg_tables where tablename = '#{table_name}'").to_hash.empty?
    yield db
  end
end

db = PG.connect(ENV["DATABASE_URL"])
create_table(db, "tasks") do |db|
  res = db.exec("create table tasks(id serial primary key, description text not null, done boolean, user_id integer)")
end

create_table(db, "users") do |db|
  res = db.exec("create table users(id serial primary key, name varchar(100), email varchar(50), password varchar(100))")
end

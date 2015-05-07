require "pg"
def create_table(db, table_name)
  if db.exec("SELECT * FROM pg_catalog.pg_tables where tablename = '#{table_name}'").to_hash.empty?
    yield db
  end
end

db = PG.connect("postgres://postgres@localhost/todo_crystal")
create_table(db, "tasks") do |db|
  res = db.exec("create table tasks(id serial primary key, description text not null, done boolean)")
end

create_table(db, "users") do |db|
  res = db.exec("create table users(id serial primary key, name varchar(100), email varchar(50), password varchar(50))")
end

create_table(db, "tasks_users") do |db|
  res = db.exec("create table tasks_users(user_id integer, task_id integer)")
end

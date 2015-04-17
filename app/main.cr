require "sqlite3"
require "../web_server/server.cr"

app = Server::Base.new

PORT = 1234
p "Server running on #{PORT}"
app.run PORT

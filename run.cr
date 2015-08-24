require "./main"

app = Main.new

main_port = 1234
OptionParser.parse! do |opts|
  opts.on("-p PORT", "--port PORT", "define port to run server") do |port|
    main_port = port.to_i
  end
end
p "Server running on #{main_port}"
app.run main_port

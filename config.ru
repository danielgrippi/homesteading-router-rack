require "rack"
require "rack-proxy"
require "./homesteading/router"

ROUTES = {}

if ENV["HOMESTEADING_ROUTES"].nil?
  puts
  puts
  puts '* ENV["HOMESTEADING_ROUTES"] needs to be set before router can start'
  puts "* Example:"
  puts '  ENV["HOMESTEADING_ROUTES"]=articles:3001,feed:3002,notes:3003,photos:3004'
  puts
  exit
else
  ENV["HOMESTEADING_ROUTES"].split(",").each do |app|
    route, port   = app.split(":")
    routes[route] = port
  end
end

# Exit or Run!
if ROUTES == {}
  puts
  puts "* Homesteading Router needs some apps with app.json files"
  puts
  puts "* For example:"
  puts "/my-site"
  puts "/my-site/homesteading-rack-router"
  puts "/my-site/homesteading-feed/app.json"
  puts "/my-site/homesteading-note/app.json"
  puts "/my-site/homesteading-photo/app.json"
  puts
  puts "* Each app.json file needs a route in it:"
  puts '  "routes": {'
  puts '    "path": "notes"'
  puts '  }'

  puts
  exit
else
  run Homesteading::Router.new
end

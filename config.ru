require "rack"
require "rack-proxy"
require "./homesteading/router"
require "./homesteading/help"

ROUTES = {}

if ENV["HOMESTEADING_ROUTES"].nil?
  Homesteading::Help.print("nil_env_var")
  exit
else
  ENV["HOMESTEADING_ROUTES"].split(",").each do |app|
    route, port   = app.split(":")
    ROUTES[route] = port
  end
end

# Exit or Run!
if ROUTES == {}
  Homesteading::Help.print("no_routes")
  exit
else
  run Homesteading::Router.new
end

require "rack"
require "rack-proxy"
require "./homesteading/router"
require "./homesteading/help"

ROUTES = {}

# Exit or build up routes table
if ENV["HOMESTEADING_ROUTES"].nil?
  Homesteading::Help.print("nil_env_var")
  exit 1
else
  ENV["HOMESTEADING_ROUTES"].split(",").each do |app|
    route, port   = app.split(":")
    ROUTES[route] = port
  end
end

# Exit or run
if ROUTES == {}
  Homesteading::Help.print("no_routes")
  exit 1
else
  run Homesteading::Router.new
end

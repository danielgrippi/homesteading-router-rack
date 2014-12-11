require "rack"
require "rack-proxy"
require "./homesteading/router"
require "./homesteading/help"

ROUTES = {}

# APPS = ENV["HOMESTEADING_ROUTES"]
APPS = "notes@@@sbbme-note.herokuapp.com,bookmarks@@@sbbme-bookmark.herokuapp.com"

# Exit or build up routes table
if ENV["HOMESTEADING_ROUTES"].nil?
  Homesteading::Help.print("nil_env_var")
  exit 1
else
  APPS.split(",").each do |app|
    route, host   = app.split("@@@")
    ROUTES[route] = host
  end
end

# Exit or run
if ROUTES == {}
  Homesteading::Help.print("no_routes")
  exit 1
else
  run Homesteading::Router.new
end

require "rack"
require "rack-proxy"
require "json"
require "optparse"
require "./homesteading/router"


# Kill all HS:Publisher apps when HS:Router is stopped
ROUTERS = []
Signal.trap("INT") do
  ROUTERS.each do |io|
    puts "Stopping HS:Publisher app at PID: #{io.pid}"
    Process.kill "SIGINT", io.pid
  end

  Homesteading::Router.stop
  exit
end


# Write error messages
no_routes = '
Homesteading Router needs some HS:Publisher apps with app.json files.

For example:
  /my-site
  /my-site/homesteading-rack-router
  /my-site/homesteading-feed/app.json
  /my-site/homesteading-note/app.json
  /my-site/homesteading-photo/app.json"

Each app.json file needs a route in it:
  "routes": {
    "path": "notes"
  }

'


# Build up routes hash from app.json files
ROUTES  = Hash.new("")
hs_path = ".." # TODO check an ENV for hs_path first

Dir.glob("#{hs_path}/**").each_with_index do |app, index|
  app_file_path = app + "/app.json"

  if File.exist?(app_file_path)
    app_file  = JSON.parse(File.read(app_file_path))
    app_route = app_file["routes"]

    if app_route
      app_name = app_file["name"]
      app_path = app_route["path"]
      app_port     = index + 3001

      app_config = {
        "app_dir" => app,
        "port"    => app_port
      }

      if app_name.downcase =~ /feed/
        ROUTES["feed"]   = app_config
      else
        ROUTES[app_path] = app_config
      end

    end

    # TEMP HACK TODO FIXME
    unless ROUTES == {}
      ROUTES["assets"] = {
        "app_dir" => "../assets",
        "port"    => 9999
      }
    end

  end
end


# Exit or Run!
if ROUTES == {}
  puts no_routes
  exit
else
  # Start all of the HS apps
  ROUTES.each do |route, app|
    next if route == "assets" # TEMP HACK TODO FIXME
    Homesteading::Router.start(app)
  end

  # Start the router
  run Homesteading::Router.new
end

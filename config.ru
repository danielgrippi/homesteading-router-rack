require "rack-proxy"
require "./app"
require "json"


ROUTES = Hash.new("")

Dir.glob("../**").each_with_index do |app, index|
  path = app + "/app.json"

  if File.exist?(path)
    app_file  = JSON.parse(File.read(path))
    app_route = app_file["routes"]

    if app_route
      app_path = app_route["path"]
      port     = index + 3000

      if app_file["name"].downcase =~ /feed/
        ROUTES["feed"] = port
      else
        ROUTES[route]  = port
      end
    end

    unless ROUTES == {}
      ROUTES["assets"] = 9999 # TEMP HACK TODO FIXME
    end

  end
end


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


if ROUTES == {}
  puts no_routes
  exit
else
  run App.new
end

require "rack"
require "rack-proxy"
require "json"
require "optparse"

require "./app"


# Parse command line options
options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Learning Option parsing in Ruby"

  opts.on("-p", "--path PATH", "Path of the constelation of Homesteading apps") do |opt_path|
    options[:hs_path] = opt_path
  end
end
optparse.parse!



# Build up routes hash from app.json files
ROUTES  = Hash.new("")
hs_path = options[:hs_path] || ".."

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
        ROUTES["feed"] = app_config
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


# Exit or Run!
if ROUTES == {}
  puts no_routes
  exit
else
  puts ROUTES
  # .each do |route|

  # end
  Rack::Handler::WEBrick.run(App.new, Port: 3000)
end

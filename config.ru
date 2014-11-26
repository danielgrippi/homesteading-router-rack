require "rack-proxy"
require "./app"
require "json"


ROUTES = Hash.new("")

Dir.glob("../**").each_with_index do |app, index|
  path = app + "/app.json"

  if File.exist?(path)
    app_file    = JSON.parse(File.read(path)) if File.exist?(path)
    route       = app_file["routes"]["path"]
    port        = index + 3000

    if app_file["name"].downcase =~ /feed/
      ROUTES["feed"] = port
    else
      ROUTES[route]  = port
    end

    apps["assets"] = 9999 # TEMP HACK TODO FIXME
  end
end

run App.new

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

puts ROUTES

# ROUTES = {
#   assets:    9999, # TEMP HACK TODO FIXME
#
#   hub:       3001,
#   feed:      3002,
#
#   articles:  3003,
#   bookmarks: 3004,
#   checkins:  3005,
#   contacts:  3006,
#   events:    3007,
#   lists:     3008,
#   notes:     3009,
#   pages:     3010,
#   photos:    3011,
#   places:    3012,
#   recipes:   3013,
#   resumes:   3014,
#   rsvps:     3015,
#   sleeps:    3016,
#   sounds:    3017,
#   tasks:     3018,
#   videos:    3019,
#   walks:     3020,
#   weights:   3021,
# }

run App.new

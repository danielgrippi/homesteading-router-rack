require "rack"
require "rack-proxy"
require "./homesteading/router"

# TODO build this up from ENV[HOMESTEADING_ROUTES]
ROUTES = {
  "articles"  => 3001,
  "bookmarks" => 3002,
  "events"    => 3003,
  "feed"      => 3004,
  "notes"     => 3005,
  "photos"    => 3006,
  "sounds"    => 3007,
  "videos"    => 3008,
  "walks"     => 3009,
  "weights"   => 3010
}

# Exit or Run!
if ROUTES == {}
  puts '
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
  exit
else
  # puts
  # puts "ENV['HOMESTEADING_ROUTES']: #{ENV["HOMESTEADING_ROUTES"]}"
  # puts "ROUTES:                     #{ROUTES}"
  run Homesteading::Router.new
end

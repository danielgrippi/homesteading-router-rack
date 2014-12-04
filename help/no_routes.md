* Homesteading Router needs some apps with app.json files

* Example:

/my-site
/my-site/homesteading-rack-router
/my-site/homesteading-feed/app.json
/my-site/homesteading-note/app.json
/my-site/homesteading-photo/app.json

* Each app.json file needs a route in it:

    "routes": {
      "path": "notes"
    }

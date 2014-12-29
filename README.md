# Homesteading Router Rack

https://github.com/homesteading/homesteading-router-rack


## Description

A Rack based proxy server to coordinate multiple Homesteading apps as one site.


## Current Version

0.0.4


## Code Status

[![Build Status](https://api.travis-ci.org/homesteading/homesteading-router-rack.png)](https://travis-ci.org/homesteading/homesteading-router-rack)
[![Code Climate](https://codeclimate.com/github/homesteading/homesteading-router-rack.png)](https://codeclimate.com/github/homesteading/homesteading-router-rack)
[![Dependencies](https://gemnasium.com/homesteading/homesteading-router-rack.png?travis)](https://gemnasium.com/homesteading/homesteading-router-rack)


## Requirements

- [ruby](http://ruby-lang.org)
- [rubygems](https://rubygems.org)
- [bundler](http://bundler.io)
- [rake](https://github.com/jimweirich/rake)
- [rack](https://github.com/rack/rack)


## Installation

Install as part of a Homesteading constellation:

```bash
homesteading new path/to/site
```

Or clone the repo directly:

```bash
git clone https://github.com/homesteading/homesteading-router-rack.git
```


## Usage

Install as part of a Homesteading constellation:

```bash
homesteading new path/to/install/location
cd path/to/install/location
homesteading server
```

Or run directly:

Set an ENV variable called `ENV["HOMESTEADING_ROUTES"]` that looks like this:

```bash
articles:3001,bookmarks:3002,notes:3003,videos:3004
```

Start each Homesteading publisher app on its respective port:

```bash
homesteading new mysite
cd mysite
cd homesteading-article
rails server -p 3001
cd ../homesteading-bookmark
rails server -p 3002
```

Etc.

Then start the router directly on port 3000.

```bash
rackup -p 3000
```


## Authors

* Shane Becker / [@veganstraightedge](https:github.com/veganstraightedge)


## Contributions

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/homesteading/homesteading/issues).


## License

**PUBLIC DOMAIN**

Your heart is as free as the air you breathe. <br>
The ground you stand on is liberated territory.

In legal text, Homesteading Router Rack is dedicated to the public domain
using Creative Commons -- CC0 1.0 Universal.

[http://creativecommons.org/publicdomain/zero/1.0](http://creativecommons.org/publicdomain/zero/1.0 "Creative Commons &mdash; CC0 1.0 Universal")

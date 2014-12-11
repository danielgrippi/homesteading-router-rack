module Homesteading
  class Router < Rack::Proxy

    def rewrite_env(env)
      request          = Rack::Request.new(env)
      path_pieces      = request.path.split("/").reject{ |i| i == "" }

      env["HTTP_HOST"] = "http://#{ROUTES[path_pieces.first || "feed"]}"
      env
    end

  end
end

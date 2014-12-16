module Homesteading
  class Router < Rack::Proxy

    def rewrite_env(env)
      request     = Rack::Request.new(env)
      path_pieces = request.path.split("/").reject{ |i| i == "" }

      if path_pieces.empty?
        app = ROUTES["feed"]
      else
        app = ROUTES[path_pieces.first]
      end

      env["HTTP_HOST"] = "http://#{app}"
      env
    end

  end
end

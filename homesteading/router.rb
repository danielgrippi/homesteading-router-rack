module Homesteading
  class Router < Rack::Proxy

    def rewrite_env(env)
      request     = Rack::Request.new(env)
      path_pieces = request.path.split("/").reject{ |i| i == "" }

      if request.path == "/"
        port = ROUTES["feed"]["port"]
      else
        port = ROUTES[path_pieces.first]["port"]
      end

      env["HTTP_HOST"] = "localhost:#{port}"
      env
    end

  end
end

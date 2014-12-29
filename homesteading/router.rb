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

      host, port = app.split(":")

      if port.nil?
        env["SERVER_PORT"] = 80
      else
        env["SERVER_PORT"] = port
      end

      env["HTTP_HOST"] = host

      env
    end

  end
end

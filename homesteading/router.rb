module Homesteading
  class Router < Rack::Proxy

    def rewrite_env(env)
      request     = Rack::Request.new(env)
      path_pieces = request.path.split("/").reject{ |i| i == "" }

      app = path_pieces.empty? ? ROUTES["feed"] : ROUTES[path_pieces.first]

      app ||= ROUTES["feed"]
      host, port = app.split(":")

      env["SERVER_PORT"] = port || 80
      env["HTTP_HOST"]   = host
      env
    end

  end
end

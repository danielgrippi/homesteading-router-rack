class App < Rack::Proxy

  def rewrite_env(env)
    request     = Rack::Request.new(env)
    path_pieces = request.path.split("/").reject{ |i| i == "" }

    if request.path == "/"
      port = ROUTES[:feed]
    else
      port = ROUTES[path_pieces.first.to_sym]
    end

    env["HTTP_HOST"] = "localhost:#{port}"
    env
  end

end

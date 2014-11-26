class App < Rack::Proxy

  def rewrite_env(env)
    request = Rack::Request.new(env)
    if request.path    =~ %r{^/notes}
      env["HTTP_HOST"] = "localhost:3001"
    elsif request.path =~ %r{^/photos}
      env["HTTP_HOST"] = "localhost:3002"
    else
      env["HTTP_HOST"] = "localhost:3000"
    end
    env
  end

end

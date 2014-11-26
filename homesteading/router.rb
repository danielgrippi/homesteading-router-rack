module Homesteading
  class Router < Rack::Proxy

    class << self
      def start(app)
        ROUTERS << IO.popen("cd #{File.expand_path(app["app_dir"])} && bin/rails server -d --port #{app["port"].to_s}", "w")
      end

      def stop
        # TEMP HACK TODO FIXME
        # This is overly aggressive, but the above kill isn't working
        system "killall ruby"
      end
    end


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

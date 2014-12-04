module Homesteading
  class Help
    class << self

      def print(path)
        # TODO better way?
        help_dir = File.expand_path("../../help/", __FILE__)
        file     = "#{help_dir}/#{path}.md"

        puts
        puts File.read(file)
        puts
      end

    end
  end
end

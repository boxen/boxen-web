module Views
  module Splash
    class Script
      def initialize(params = {})
        @access_token = params.delete(:access_token)
      end

      def endpoint
        "https://api.github.com/repos/#{ENV['REPOSITORY']}/tarball"
      end

      def download_url
        "#{endpoint}?access_token=#{@access_token}"
      end

      def repo_name
        ENV['REPOSITORY']
      end
    end
  end
end

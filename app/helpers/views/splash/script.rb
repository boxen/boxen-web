module Views
  module Splash
    class Script
      def initialize(params = {})
        @access_token = params.delete(:access_token)
      end

      def endpoint
        "#{github_api_url}/repos/#{ENV['REPOSITORY']}/tarball"
      end

      def download_url
        "#{endpoint}?access_token=#{@access_token}"
      end

      def github_api_url
        ghe_url = ENV['GITHUB_ENTERPRISE_URL']
        ghe_url ? "#{ghe_url}/api/v3" : "https://api.github.com"
      end

    end
  end
end

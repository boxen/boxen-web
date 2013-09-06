require 'cgi'

module Views
  module Splash
    class Script
      def initialize(params = {})
        @access_token = params.delete(:access_token)
        @login = params.delete(:login)
      end

      def endpoint
        escaped_ref_name = CGI.escape(ref_name)
        "#{github_api_url}/repos/#{repo_name}/tarball/#{escaped_ref_name}"
      end

      def download_url
        "#{endpoint}?access_token=#{@access_token}"
      end

      def access_token
        @access_token
      end

      def login
        @login
      end

      def repo_name
        ENV['REPOSITORY']
      end

      def ref_name
        ENV['REF'] || 'master'
      end

      def user_org
        ENV['USER_ORG']
      end

      def github_api_url
        ghe_url = ENV['GITHUB_ENTERPRISE_URL']
        ghe_url ? "#{ghe_url}/api/v3" : "https://api.github.com"
      end
    end
  end
end

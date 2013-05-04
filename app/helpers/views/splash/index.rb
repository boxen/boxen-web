module Views
  module Splash
    class Index
      include ActionView::Helpers::UrlHelper

      def initialize(params = {})
        @user    = params.delete(:user)
        @request = params.delete(:request)
      end

      def login
        @user.login
      end

      def server_name
        @request.server_name
      end

      def url_scheme
        @request.env.fetch(
          'HTTP_X_FORWARDED_PROTO',
          @request.env['rack.url_scheme']
        )
      end

      def script_url
        "#{url_scheme}://#{server_name}#{script_path}"
      end

      def script_path
        "/script/#{@user.short_access_token}.sh"
      end

      def secondary_message
        ENV['SECONDARY_MESSAGE']
      end

      def user_org
        ENV['USER_ORG']
      end
    end
  end
end

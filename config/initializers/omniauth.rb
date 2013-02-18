require "omniauth"
require "omniauth-github"

missing = %w(REPOSITORY GITHUB_CLIENT_ID GITHUB_CLIENT_SECRET).
  reject { |k| ENV.include? k }

unless missing.empty?
  abort "Missing from ENV: #{missing.join ', '}"
end

id     = ENV["GITHUB_CLIENT_ID"]
secret = ENV["GITHUB_CLIENT_SECRET"]
options = {:scope => "user,repo"}

if ENV['GITHUB_ENTERPRISE_URL']
  options.merge!({:client_options => {
    :site          => "#{ENV['GITHUB_ENTERPRISE_URL']}/api/v3",
    :authorize_url => "#{ENV['GITHUB_ENTERPRISE_URL']}/login/oauth/authorize",
    :token_url     => "#{ENV['GITHUB_ENTERPRISE_URL']}/login/oauth/access_token"}
  })
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, id, secret, options
end

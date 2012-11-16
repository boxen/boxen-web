require "omniauth"
require "omniauth-github"

missing = %w(REPOSITORY GITHUB_CLIENT_ID GITHUB_CLIENT_SECRET).
  reject { |k| ENV.include? k }

unless missing.empty?
  abort "Missing from ENV: #{missing.join ', '}"
end

id     = ENV["GITHUB_CLIENT_ID"]
secret = ENV["GITHUB_CLIENT_SECRET"]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, id, secret, :scope => "user,repo"
end

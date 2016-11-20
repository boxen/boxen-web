class AuthController < ApplicationController
  skip_before_filter :auth, :only => :create

  def create
    if access?
      user = User.where(
        :github_id => auth_hash['uid']
      ).first_or_create

      user.login = auth_hash['info']['nickname']
      user.access_token = auth_hash.credentials['token']
      user.save

      session[:github_user_id] = auth_hash['uid']
      redirect_to session.delete(:return_to)
    else
      render :status => :forbidden, :text => "Forbidden"
    end
  end

  def destroy
    session.clear
    redirect_to (ENV['GITHUB_ENTERPRISE_URL'] || "https://github.com")
  end

  protected

  def github_api_url
    ghe_url = ENV['GITHUB_ENTERPRISE_URL']
    ghe_url ? "#{ghe_url}/api/v3" : "https://api.github.com"
  end

  def auth_hash
    env['omniauth.auth']
  end

  def access?
    (check_org_access? && org_access?) ||
    (check_team_access? && team_access?) ||
    (check_user_access? && user_access?) ||
    (!check_org_access? && !check_team_access? && !check_user_access?)
  end

  def check_org_access?
    !ENV['GITHUB_ORG'].nil?
  end

  def org_access?
    nick   = auth_hash['info']['nickname']

    host   = github_api_url
    path   = "/orgs/#{ENV['GITHUB_ORG']}/members/#{nick}"
    params = "access_token=#{auth_hash.credentials['token']}"
    uri    = URI.parse("#{host}#{path}?#{params}")

    http         = Net::HTTP.new(uri.host, uri.port)
    request      = Net::HTTP::Get.new("#{uri.path}?#{uri.query}")
    http.use_ssl = true

    http.request(request).code == '204'
  end

  def check_team_access?
    !ENV['GITHUB_TEAM_ID'].nil?
  end

  def team_access?
    nick   = auth_hash['info']['nickname']

    host   = github_api_url
    path   = "/teams/#{ENV['GITHUB_TEAM_ID']}/members/#{nick}"
    params = "access_token=#{auth_hash.credentials['token']}"
    uri    = URI.parse("#{host}#{path}?#{params}")

    http         = Net::HTTP.new(uri.host, uri.port)
    request      = Net::HTTP::Get.new("#{uri.path}?#{uri.query}")
    http.use_ssl = true

    http.request(request).code == '204'
  end

  def check_user_access?
    !ENV['GITHUB_LOGIN'].nil?
  end

  def user_access?
    ENV['GITHUB_LOGIN'] == auth_hash['info']['nickname']
  end
end

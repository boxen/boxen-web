Boxen::Application.routes.draw do
  root :to => "splash#index"
  get "/auth/github/callback" => "auth#create"
  get "/logout" => "auth#destroy"

  get "/script/:token.sh" => "splash#script"
end

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: "login", sign_out: "logout"},
    controllers: { omniauth_callbacks: "omniauth_callbacks" }
  get 'static_pages/home'
  root 'static_pages#home'
  get 'static_pages/show'
  post 'static_pages/add_follow'
  get '/recommendations' => "static_pages#recommendations"
end

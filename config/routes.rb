Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, module: "users", path: "", path_names: {
      sign_in: "login",
      sign_out: 'logout',
  }

  controller :pages do
    root action: "index"
  end

  scope :articles, controller: :articles do
    root action: :index, as: :articles
    get "id", as: :article, action: :show
  end

  match "*url", to: "application#render_not_found", via: :all
end

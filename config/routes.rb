Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, module: "users", path: "", path_names: {
      sign_in: "login",
      sign_out: 'logout',
  }

  controller :pages do
    root action: "index"
  end

  match "*url", to: "application#render_not_found", via: :all
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: 'json' } do
    scope module: :v1, path: '/v1' do
      post 'login', to: 'authentication#login'
    end
  end
end

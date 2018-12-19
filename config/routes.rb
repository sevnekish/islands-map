require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV['SIDEKIQ_LOGIN'] && password == ENV['SIDEKIQ_PASSWORD']
    end
  end
  mount Sidekiq::Web, at: '/sidekiq'

  namespace :v1 do
    resource :maps, only: :create

    resources :islands, only: [:index, :show]
  end
end

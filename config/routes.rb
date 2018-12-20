Rails.application.routes.draw do
  namespace :v1 do
    resource :map, only: :create do
      resource :render, only: :create
    end

    resources :islands, only: [:index, :show]
  end
end

Rails.application.routes.draw do
  namespace :v1 do
    resource :map, only: :create

    resource :rendered_map, only: :show

    resources :islands, only: [:index, :show]
  end
end

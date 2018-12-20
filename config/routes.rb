Rails.application.routes.draw do
  namespace :v1 do
    resource :maps, only: :create

    resource :rendered_maps, only: :show

    resources :islands, only: [:index, :show]
  end
end

Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

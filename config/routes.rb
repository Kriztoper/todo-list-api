Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      post '/tasks/reorder/:this_id/to/:target_order_number', to: 'tasks#reorder'
      resources :tasks
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

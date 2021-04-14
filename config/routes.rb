Rails.application.routes.draw do
  resources :crime_entries
  resources :locations
  get 'crime/crime' => 'crime#crime'
  get 'analytics/city' => 'analytics#analytics'

  mount ActionCable.server => '/news'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

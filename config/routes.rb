Rails.application.routes.draw do
  resources :crime_entries
  resources :crime_types
  resources :locations
  get 'analytics/analytics'
  get 'crime/crime' => 'crime#crime'
  get 'news/news'
  get 'home/home'

  mount ActionCable.server => '/news'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

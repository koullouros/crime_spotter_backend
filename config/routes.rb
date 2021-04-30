Rails.application.routes.draw do
  # resources :crime_entries
  # resources :locations
  get 'crime/crime' => 'crime#crime'
  get 'statistics/city' => 'analytics#analytics'

  # routes for log actions
  post 'statistics/log_visit' => 'log_visit#log_visit'
  get 'statistics/get_visit_count' => 'log_visit#get_visit_count'

  post 'statistics/log_search' => 'log_search#log_search'
  get 'statistics/get_search_count' => 'log_search#get_search_count'

  get 'autocomplete' => 'crime#autocomplete'
  mount ActionCable.server => '/news'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

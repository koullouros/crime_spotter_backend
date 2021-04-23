Rails.application.routes.draw do
  # resources :crime_entries
  # resources :locations
  get 'crime/crime' => 'crime#crime'
  get 'statistics/city' => 'analytics#analytics'

  # routes for log actions
  post 'log_visit/log_visit' => 'log_visit#log_visit'
  # post 'log_visit/get_visits' => 'log_visit#get_visits'
  post 'log_visit/get_visit_count' => 'log_visit#get_visit_count'

  get 'autocomplete' => 'crime#autocomplete'
  mount ActionCable.server => '/news'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

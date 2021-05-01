Rails.application.routes.draw do
  get 'crime/crime' => 'crime#crime'
  get 'statistics/city' => 'analytics#analytics'
  get 'geocode/forward' => 'crime#forward'

  # routes for log actions
  get 'statistics/log_visit' => 'log_visit#log_visit'
  get 'statistics/get_visit_count' => 'log_visit#get_visit_count'

  get 'statistics/get_search_count' => 'log_search#get_search_count'

  get 'autocomplete' => 'crime#autocomplete'
  mount ActionCable.server => '/news'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

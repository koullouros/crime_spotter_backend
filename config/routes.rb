Rails.application.routes.draw do
  get 'analytics/analytics'
  get 'crime/crime' => 'crime#crime'
  post 'analytics/city' => 'analytics#analytics'
  get 'news/news'
  get 'home/home'

  mount ActionCable.server => '/news'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'crime/crime' => 'crime#crime'
  get 'news/news'
  get 'home/home'

  mount ActionCable.server => '/news'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

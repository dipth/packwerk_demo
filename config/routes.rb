Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  draw('weather')

  # Defines the root path route ("/")
  root 'weather#new'
end

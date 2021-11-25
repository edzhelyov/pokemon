Rails.application.routes.draw do
  resources :pokemons, only: %w(index show)
end

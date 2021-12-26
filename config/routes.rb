Rails.application.routes.draw do
  namespace :api do
    resources :recipes, only: %i[index create show]
  end
end

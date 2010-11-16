Yaktrak::Application.routes.draw do
  resources :trackings
  root :to => "trackings#new"
end

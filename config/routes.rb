Rails.application.routes.draw do
  resources :messages
  resources :evaluations
  resources :advertisements
  resources :contacts, only: [:index, :create]
  devise_for :users, controllers: { omniauth_callbacks: "callbacks", registrations: "registrations"}
  match '/usuarios', to: 'users#allUsers', via: [:get]
  match '/usuarios/:id', to: 'users#profile', via: [:get]
  match '/usuarios/follow/:id', to: 'users#follow', via: [:get]
  match '/usuarios/unfollow/:id', to: 'users#unfollow', via: [:get]
  match '/usuarios/:id/timeline', to: 'users#timeline', via: [:get]
  match '/usuarios/:id/seguidores', to: 'users#followers', via: [:get]
  match '/usuarios/:id/seguindo', to: 'users#followings', via: [:get]
  match '/usuarios/addFavourite/:id', to: 'favourites#addFavourite', via: [:get]
  match '/usuarios/removeFavourite/:id', to: 'favourites#removeFavourite', via: [:get]
  match '/usuarios/:id/anuncios', to: 'users#advertisements', via: [:get]
  match '/usuarios/:id/anuncios/:id', to: 'advertisements#show', via:[:get]
  match '/usuarios/:id/favoritos', to: 'favourites#favourite', via: [:get]
  match '/usuarios/:id/qualificacoes', to: 'users#evaluations', via: [:get]
  match '/search/autocomplete', to: 'users#autocomplete', via: [:get]
  match '/anuncios/cidade/:id', to: 'cities#filtercity', via: [:get]
  match '/anuncios/excluirads/:id', to: 'advertisements#delete_ads', via: [:get]
  match '/anuncios/vender/:id', to: 'advertisements#sell', via: [:get]
  match '/search', to: 'searchs#search', via: [:get]
  match '/sobre', to: 'publics#about', via: [:get]
  match '/contato', to: 'contacts#new', via: [:get]
  match '/ajuda', to: 'publics#callcenter', via: [:get]
  match '/politica_de_privacidade', to: 'publics#privacy', via: [:get]
  root 'publics#index'
end

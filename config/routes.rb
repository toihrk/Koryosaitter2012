Koryosaitter::Application.routes.draw do
  root :to => 'welcome#index'

  match "/auth/:provider/callback", :to => 'welcome#callback'
  get "/signout", :to => 'welcome#signout', :as => "signout"
  
  get "/about", :to => 'welcome#about', :as => "about"

  get "/mainscreen", :to => 'screens#main', :as => "mainscreen"
  get "/subscreen", :to => 'screens#sub', :as => "subscreen"
  get "/clientscreen", :to => 'screens#client', :as => "clientscreen"

  get "/adminscreen", :to => 'screens#admin', :as => "adminscreen"

  get "/client", :to => 'client#index', :as => "client"
  post "/client/tweet", :to => 'client#post', :as => "tweet"
  post "/client/fav", :to => 'client#fav', :as => "fav"
end

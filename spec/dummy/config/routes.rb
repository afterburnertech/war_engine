Rails.application.routes.draw do

  mount WarEngine::Engine => "/"
  
  get "/things" => "things#index", :as => :things

end

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'countries#index'

  resources :audios
#  resources :cities
  get 'cities/:id'  => 'places#show'


#  resources :countries
  get 'countries'      => 'countries#index'
  get 'countries/:id'  => 'countries#show'
  get 'countries/:id/states'  => 'countries#states'

  resources :collections
  post 'collections/:id/upload'     => 'collections#upload'
  post 'collections/:id/addabout'   => 'collections#addabout'
  post 'collections/:id/addweb'     => 'collections#addweb'

  resources :dbox




  resources :documents


  resources :feeds
  resources :finances

  resources :groups
  get 'groups/:id/enter'         => 'groups#addmember'
  get 'groups/:id/leave'         => 'groups#delmember'

  get 'groups/:id/finances'      => 'groups#finances'

  resources :events
  get 'events/:id/addparticipant' => 'events#addparticipant'


  resources :images
  resources :people
  resources :places
  resources :projects

#  resources :states
  get 'states/:id'  => 'places#show'




  get  'home'                => 'home#index'
  get  'home/preferences'    => 'home#preference'
  post 'home/update'         => 'home#update'

  get  'home/friends'        => 'home#friends'
  get  'home/finances'       => 'home#finances'

  post 'home/comments'       => 'home#comments'
  get  'home/uncomments'     => 'home#uncomments'
  get  'home/follows'        => 'home#follows'
  get  'home/unfollows'      => 'home#unfollows'

  get  'home/requests'       => 'home#requests'
  get  'home/accepts'        => 'home#accepts'
  get  'home/rejects'        => 'home#rejects'


  get  'home/lives'          => 'home#lives'

  get  'home/likes'          => 'home#likes'

  get  'home/collections'    => 'home#collections'
  get  'home/groups'         => 'home#groups'
  get  'home/list'           => 'home#list'

  post 'users/:id/addevent'       => 'users#addevent'
  post 'users/:id/addcollection'  => 'users#addcollection'



  resources :classes
  post 'classes/:id/addclasse'  => 'classes#addclasse'
  post 'classes/:id/addmethod'  => 'classes#addmethod'



  get  '/login' => 'sessions#new'
  get  '/logout' => 'sessions#destroy'
  post '/sessions' => 'sessions#create'



  resources :subjects
  post '/subjects/:id/addsub' => 'subjects#addsub'


  resources :languages


  resources :institutions
  resources :universities



  resources :users
  get  'users/:id/addrequest' => 'users#addrequest'




  get 'statistics' => "statistics#index"




  get "/dbox/:id/file" => 'dbox#file'


  get "/thumbnails/u/:id" => 'thumbnails#showupload'
  get "/thumbnails/d/:id" => 'thumbnails#showdefault'
  get "/thumbnails/geomaps" => 'thumbnails#geomaps'
  get "/thumbnails/online" => 'thumbnails#online'


  get "/search"  => "search#index"



  get '/shell/templates'  => 'shell#index'
  get '/shell/actions'    => 'shell#actions'
  get '/shell/forms'      => 'shell#forms'

end

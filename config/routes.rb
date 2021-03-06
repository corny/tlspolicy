Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :domains, only: [:index, :show], constraints: {id: /[^\/]*/}
  resources :mx_hosts, only: :index

  get 'statistics'   => 'welcome#statistics'
  get 'certificates' => 'welcome#certificates'
  get 'issuers'      => 'welcome#issuers'
  get 'roots'        => 'welcome#roots'
  get 'status'       => 'status#index'

  get 'certificates/top' => 'certificates#top'

  resources :certificates, only: [:show]

end

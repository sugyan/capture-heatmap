Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get '/' => 'root#index'

  namespace :api do
    constraints :format => :json do
      get 'captured_logs' => 'captured_logs#index'
    end
  end
end

ClearanceOauthProviderExample::Application.routes.draw do
  resource :account, controller: 'users' do
    resources :applications
  end

  root to: 'puppies#index'
end

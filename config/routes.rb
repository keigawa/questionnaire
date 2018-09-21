# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: {
  session:      'admins/session',
  password:     'admins/password',
  registration: 'admins/registration'
}
  devise_for :users, controllers: {
  session:      'users/session',
  password:     'users/password',
  registration: 'users/registration'
}

  resources :surveys do
   resources :checkboxes do
     resources :checkbox_options
   end
   resources :radiobuttons do
     resources :radiobutton_options
   end
      resources :questions, :textboxes, :textareas, :answers, :answer_textboxes, :answer_textareas, :answer_checkbox_options, :answer_radiobutton_options
  end
  resources :companies do
    resource :president do
      resource :president_image 
    end
    resources :users  
  end
    resource :image

  post 'confirm', to: 'confirms#set_flag'
  get 'verify', to: 'verifies#display'
  post 'verify', to: 'verifies#done_flag'
  delete 'verify', to: 'verifies#destroy'
  get 'cbanswer', to: 'cbanswers#edit'
  put 'cbanswer', to: 'cbanswers#update'
  get 'rbanswer', to: 'rbanswers#edit'
  put 'rbanswer', to: 'rbanswers#update'
  get 'result', to: 'results#index'
  get 'consequence', to: 'consequences#display'
  get 'home_user', to: 'home_users#display'
  delete 'delete_all', to: 'delete_alls#destroy'
  get 'profile', to: 'profiles#display'

  root 'home_users#display'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

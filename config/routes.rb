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
   member do
     get 'confirm'
     get 'result'
   end
   resources :questions, :textboxes, :textareas, :answers, :answer_textboxes, :answer_checkbox_options, :answer_radiobutton_options
  end

  root 'surveys#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

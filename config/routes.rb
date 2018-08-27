Rails.application.routes.draw do
  devise_for :users
  resources :surveys do
    resources :answers,:questions do
      resources :textboxs, :textareas, :checkboxs, :radiobuttons
    end
  end

  root "surveys#index"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

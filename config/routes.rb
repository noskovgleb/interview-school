Rails.application.routes.draw do
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end
  resources :subjects
  resources :students do
    member do
      post 'add_section'
      delete 'remove_section/:section_id', to: 'students#remove_section', as: 'remove_section'
    end
  end
  resources :sections

  root to: 'subjects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

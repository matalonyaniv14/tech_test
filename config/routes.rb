Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/request_session", to: "base#request_session"
      resources :users, only: [:new, :create, :update]

      get "/users/:id/course_modules", to: "course_modules#index"
      get "/users/:id/course_modules/:course_module_id", to: "course_modules#show"

      get "/users/:id/user_course_modules", to: "user_course_modules#index"
      get "/users/:id/user_course_modules/:user_course_module_id", to: "user_course_modules#show"
      post "/users/:id/user_course_modules", to: "user_course_modules#create"
    end
  end
end

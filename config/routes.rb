Rails.application.routes.draw do
  resource :session, only: %i[ new create destroy ] do
    scope module: :sessions do
      resource :magic_link, only: %i[ new create ]
    end
  end

  resources :activities
  post "mark_night_as_sleep(/:date)", to: "activities#mark_night_as_sleep", as: :mark_night_as_sleep

  namespace :activity do
    resources :categories, only: %i[ create update destroy ]
  end


  resource :calendar, only: :show
  resource :statistics, only: :show
  resource :user_profile_link, only: %i[ create update destroy ]
  get "shared_statistics/:token", to: "public_statistics#show", as: :public_statistics
  resource :settings, only: %i[ show update]

  get "up" => "rails/health#show", as: :rails_health_check

  match "/:code",
  to: "errors#show",
  as: :errors,
  via: :all,
  constraints: {
    code: Regexp.new(
      ErrorsController::VALID_STATUS_CODES.join("|")
    )
  }

  scope "(:locale)", locale: /en|fr/ do
    root "home#show"
  end
end

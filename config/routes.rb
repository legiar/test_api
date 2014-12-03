Rails.application.routes.draw do

  namespace :api, as: nil do
    namespace :v1, as: nil do

      resources :bonus_codes, only: [] do
        collection do
          get "validate"
        end
      end
    end
  end

  get "bonus_codes/validate" => "api/v1/bonus_codes#validate"
end

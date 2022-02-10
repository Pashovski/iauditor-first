Rails.application.routes.draw do
  get "/hello", to: "application#hello_world"
  get "/inspections", to: "application#inspections"

  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end

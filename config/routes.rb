Rails.application.routes.draw do

  devise_for :user

  mount V1::Base => '/api/v1'
  
end

class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  protect_from_forgery with: :exception
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username,:uid, :provider, :image, :email, :password,:password_confirmation, :name, :kind, :cnpj, :phone, :city_id, :address, :reason_social, :description)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:username,:uid, :provider, :image, :email,:password,:password_confirmation, :name, :kind, :cnpj, :phone, :city_id, :address, :reason_social, :description)}
  end

end

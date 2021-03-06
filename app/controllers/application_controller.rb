class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #Bedingung für Aufruf der Parameter - nur bei Devisecontroller
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # Datenbank bleibt gesichert, Felder werden hinzugefügt
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :birthday, :place_of_residence, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :password_confirmation, :current_password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :birthday, :place_of_residence, :password, :password_confirmation, :current_password, :remember_me) }
  end
  
end

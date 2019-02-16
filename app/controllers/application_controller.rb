# frozen_string_literal: true

class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception, prepend: true
	before_action :authenticate_user!

	before_action :configure_permitted_parameters, if: :devise_controller?

  	protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name address city state zip phone])
  	end
end

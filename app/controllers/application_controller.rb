# frozen_string_literal: true

class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception, prepend: true
	before_action :authenticate_user!

	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ebay_auth

  	protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name address city state zip phone])
  	end

    def ebay_auth
      if user_signed_in?

        if !params[:code].present? && !current_user.access_token
          client = OAuth2::Client.new(Rails.application.credentials.dig(:client_id), 
                                      Rails.application.credentials.dig(:client_secret), 
                                      site: 'https://auth.sandbox.ebay.com', 
                                      authorize_url: '/oauth2/authorize', 
                                      token_url: '/oauth2/token')
          redirect_to client.auth_code.authorize_url(redirect_uri: Rails.application.credentials.dig(:ru_name), 
                                                     scope: 'https://api.ebay.com/oauth/api_scope')
        else
          # you have an access token in the code
          if current_user.access_token
            # check if it needs refreshed
            # TODO Generate refresh token code
          else  
            EbayAuth::GetToken.run(params[:code], current_user)
          end
        end
      end
    end
end

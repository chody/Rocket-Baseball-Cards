# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
	protect_from_forgery with: :exception, prepend: true
	before_action :authenticate_user!

	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ebay_auth

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy = exception.policy.class.to_s
    action = exception.query
    flash[:error] = "You do not have permission to perform this action"
    redirect_to unauthorized_path
  end

  def unauthorized_path
    root_path
  end  


  	protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name address city state zip phone])
  	end

    def ebay_auth
      if user_signed_in?
          client = OAuth2::Client.new(Rails.application.credentials.dig(:client_id), 
                                      Rails.application.credentials.dig(:client_secret), 
                                      site: 'https://api.ebay.com', 
                                      authorize_url: 'https://auth.ebay.com/oauth2/authorize', 
                                      token_url: 'https://api.ebay.com/identity/v1/oauth2/token')

        if !params[:code].present? && !current_user.access_token
          redirect_to client.auth_code.authorize_url(redirect_uri: Rails.application.credentials.dig(:ru_name), 
                                                     scope: 'https://api.ebay.com/oauth/api_scope')
        else
          if current_user.access_token
            # check if it needs refreshed
            if current_user.refresh_at < DateTime.now
              EbayAuth::RefreshToken.run(current_user, client)
            end
          else  
            EbayAuth::GetToken.run(client, URI.unescape(params[:code]), current_user)
          end
        end
      end
    end
end

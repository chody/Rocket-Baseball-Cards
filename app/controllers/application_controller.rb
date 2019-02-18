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
        puts "SIGNED IN"  
        client_id = 'CodyHill-RocketBa-SBX-da6d6c7c3-d5095cb2'
        client_secret = 'SBX-a6d6c7c3a25e-723f-4be0-8f16-97cb'
        client = OAuth2::Client.new(client_id, client_secret, site: 'https://auth.sandbox.ebay.com', authorize_url: '/oauth2/authorize', token_url: '/oauth2/token')
        puts "CLIENT #{client.inspect}"
        ru_name = 'Cody_Hill-CodyHill-Rocket-kemlyn'
        unless params[:code].present?
          redirect_url = client.auth_code.authorize_url(redirect_uri: ru_name, scope: 'https://api.ebay.com/oauth/api_scope')
          redirect_to redirect_url
        else
          puts "CODY #{params[:code]}"
          oauth_credentials = "#{client_id}:#{client_secret}"
          encoded_credentials = Base64.strict_encode64(oauth_credentials)
          code = params[:code]
          decode = URI.escape(code)
          test = CGI::unescape(code)
          puts "DECODE #{decode}"
          puts "TEST #{test}"
          # token = client.auth_code.get_token(code, redirect_uri: ru_name, :headers => {'Authorization' => "Basic #{encoded_credentials}"}).to_hash

          # token = client.auth_code.get_token(Base64.encode64(params[:code]), redirect_uri: ru_name)
          # uri = URI.parse("https://api.sandbox.ebay.com/identity/v1/oauth2/token")
          # request = Net::HTTP::Post.new(uri)
          # request.content_type = "application/x-www-form-urlencoded"
          # request["Authorization"] = "Basic #{encoded_credentials}"
          # request.body = "grant_type=authorization_code&
          # code=#{code}&
          # redirect_uri=#{ru_name}"

          # req_options = {
          #   use_ssl: uri.scheme == "https",
          # }

          # response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          #   http.request(request)
          # end

          uri = URI.parse("https://api.sandbox.ebay.com/identity/v1/oauth2/token")
          request = Net::HTTP::Post.new(uri)
          request.content_type = "application/x-www-form-urlencoded"
          request["Authorization"] = "Basic #{encoded_credentials}"
          request.body = "grant_type=authorization_code&code=#{code}&redirect_uri=#{ru_name}"

          req_options = {
            use_ssl: uri.scheme == "https",
          }

          response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
          end

          puts "RESPONSE #{response}"
          puts "#{response.body}"

        end
      end
    end
end

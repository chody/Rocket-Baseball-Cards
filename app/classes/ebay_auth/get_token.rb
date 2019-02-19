# frozen_string_literal: true

module EbayAuth
  class GetToken
    attr_reader :code, :user

    def self.run(code, user)
      new(code, user).run
    end

    def initialize(code, user)
      @code = code
      @user = user
    end

    def run
      setup
    end

    def setup
      oauth_credentials = "#{Rails.application.credentials.dig(:client_id)}:#{Rails.application.credentials.dig(:client_secret)}"
      encoded_credentials = Base64.strict_encode64(oauth_credentials)
      uri = URI.parse("https://api.sandbox.ebay.com/identity/v1/oauth2/token")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/x-www-form-urlencoded"
      request["Authorization"] = "Basic #{encoded_credentials}"
      request.body = "grant_type=authorization_code&code=#{code}&redirect_uri=#{Rails.application.credentials.dig(:ru_name)}"

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      token = eval(response.body)
      # refresh_time = DateTime.strptime(token[:expires_at].to_s, '%s')
      refresh_time = Time.now + 2.hours
      user.update_attributes(access_token: token[:access_token],
                                     refresh_token: token[:refresh_token],
                                     refresh_at: refresh_time)
    end
  end
end
# frozen_string_literal: true

module EbayAuth
  class GetToken
    attr_reader :client, :code, :user

    def self.run(client, code, user)
      new(client, code, user).run
    end

    def initialize(client, code, user)
      @client = client
      @code = code
      @user = user
    end

    def run
      setup
    end

    def setup
      oauth_credentials = Base64.strict_encode64("#{Rails.application.credentials.dig(:client_id)}:#{Rails.application.credentials.dig(:client_secret)}")
      token = client.auth_code.get_token(code, redirect_uri: Rails.application.credentials.dig(:ru_name), headers: { 'Authorization' => "Basic #{oauth_credentials}" }).to_hash
      refresh_time = Time.now + 2.hours
      user.update_attributes(access_token: token[:access_token],
                                     refresh_token: token[:refresh_token],
                                     refresh_at: refresh_time)
    end
  end
end
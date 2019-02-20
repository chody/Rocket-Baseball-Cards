# frozen_string_literal: true

module EbayAuth
  class RefreshToken
    attr_reader :user, :client

    def self.run(user, client)
      new(user, client).run
    end

    def initialize(user, client)
      @user = user
      @client = client
    end

    def run
      setup
    end

    def setup
      oauth_credentials = Base64.strict_encode64("#{Rails.application.credentials.dig(:client_id)}:#{Rails.application.credentials.dig(:client_secret)}")
      token = client.get_token(refresh_token: user.refresh_token, redirect_uri: Rails.application.credentials.dig(:ru_name), headers: { 'Authorization' => "Basic #{oauth_credentials}" }, grant_type: "refresh_token").to_hash
      refresh_time = Time.now + 2.hours
      user.update_attributes(access_token: token[:access_token], refresh_at: refresh_time)
    end
  end
end
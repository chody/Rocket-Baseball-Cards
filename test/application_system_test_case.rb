# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :chrome

  def before_setup
    super
  end

  def after_teardown
    super
    remove_uploaded_files
  end

  def login(user = users(:one), password = 'password')
    visit new_user_session_path

    fill_in 'Username', with: user.username
    fill_in 'Password', with: password

    click_on 'Log in'

    assert_text I18n.t('devise.sessions.signed_in')
    @current_user = user
  end

  def remove_uploaded_files
    FileUtils.rm_rf("#{Rails.root}/storage_test")
  end

  Capybara.register_driver :chrome do |app|
    driver_options = {
      browser: :chrome,
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: {
          args: %w[disable-gpu --window-size=1400,1400].tap do |options|
            options << 'headless' if ENV['HEADLESS_TESTS']
          end
        }
      ),
      http_client: Selenium::WebDriver::Remote::Http::Default.new(read_timeout: 90)
    }

    Capybara::Selenium::Driver.new(app, driver_options)
  end
end
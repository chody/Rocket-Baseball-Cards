# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

ActiveSupport::TestCase.class_eval do
  fixtures :all
end

ActionDispatch::IntegrationTest.class_eval do
  include Devise::Test::IntegrationHelpers
end

Capybara.add_selector(:name) do
  xpath { |name| XPath.descendant[XPath.attr(:name).contains(name)] }
end

# frozen_string_literal: true

require 'cucumber/rails'
require 'httparty'

# Configure HTTParty base URI
module APIHelper
  include HTTParty
  base_uri 'http://localhost:3000/api/v1'
  
  def self.auth_headers(token = nil)
    headers = { 'Content-Type' => 'application/json' }
    headers['Authorization'] = "Bearer #{token}" if token
    headers
  end
end

World(APIHelper)

# Database cleaner
DatabaseCleaner.strategy = :truncation

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end


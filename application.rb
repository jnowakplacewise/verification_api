# frozen_string_literal: true

require 'rack'
require 'grape'
require_relative './app/api/verification'

Dir["#{File.dirname(__FILE__)}/app/api/**/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each { |file| require file }

module API
  class Root < Grape::API
    format :json

    get :status do
      { status: 'ok' }
    end

    mount API::Verification
  end
end

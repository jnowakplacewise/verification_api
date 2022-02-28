# frozen_string_literal: true

require 'grape'
require 'time'
require 'credit/verificator'
require_relative 'postgres_connector'

module API
  class Verification < Grape::API
    # @@verificator = Credit::Verificator.new
    format :json
    params do
      optional :id, type: Integer
      optional :code, type: String
      optional :owner, type: String
    end

    get :card do
      { card: Credit::Card.new(params[:id], params[:code], params[:owner]) }
    end

    get :verify do
      db_handler = API::DBHandler.new(:verifications)
      ver = Credit::CardVerificator.new
      card = Credit::Card.new(params[:id], params[:code], params[:owner])
      result = ver.verify(card)

      card = { card_code: card.code,
               verified_as: result,
               verified_at: Time.now.getutc }
      query = db_handler.insert_card(card)
      query.nil? ? 'NIL' : query
    end

    get :all do
      db_handler = API::DBHandler.new(:verifications)
      db_handler.get_all
    end
  end
end

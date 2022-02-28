require 'grape'
require 'credit/verificator'

module API
   class Verification < Grape::API
        @@verificator = Credit::Verificator.new
        format :json
        params do
         optional :id, type: Integer
         optional :code, type: String
         optional :owner, type: String
        end

         get :card do
            {card: Credit::Card.new(params[:id], params[:code], params[:owner])}
         end

         get :verify do
            ver = Credit::CardVerificator.new
            {verify: ver.verify(Credit::Card.new(params[:id], params[:code], params[:owner]))}
         end
   end
end
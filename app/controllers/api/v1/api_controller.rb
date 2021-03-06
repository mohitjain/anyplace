module Api
  module V1
    class ApiController < ActionController::Base
      #skip_before_action :verify_authenticity_token
      protect_from_forgery unless: -> { request.format.json? }
      respond_to :json
      before_action :set_default_content_type
      before_action :authenticate_check, except: [:utc, :signin]

      def ping
        render json: {
          message: "Hello, #{@user.name}!"
        }
      end

      def utc
        render json: { utc: Time.zone.now.utc.strftime('%Y-%m-%dT%H:%M:%S%z') }
      end

      private

      def set_default_content_type
        response.content_type = 'application/json'
      end

      def authenticate_check
        if params[:client_id].blank? || params[:auth_token].blank?
          render json: { error: 'Incomplete authentication details.' }, status: :not_acceptable
          return false
        end

        @client = Client.find_by_id_and_auth_token(params[:client_id], params[:auth_token])

        if @client.nil? or @client.user.nil?
          render json: {
            client_id: params[:client_id],
            error: 'Authentication Failed.'
          }, status: :unauthorized
          return false
        end
        @user = @client.user
      end
    end
  end

end

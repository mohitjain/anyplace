module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate_check, only: [:create]

      def create
        @user = User.new(user_params)
        unless @user.save
          @error_object = @user
          render 'api/v1/shared/errors', status: :bad_request
        else
          @client = @user.clients.create
          render 'api/v1/users/create', status: :created
        end
      end

      def sign_in

      end

      private

      def user_params
        params.require(:user).permit(
          :name,
          :email,
          :password,
        )
      end
    end
  end
end

module API::V1
  class AuthenticationController < APIController
    def login
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        @exp = Time.now + 24.hours.to_i
        payload = { user_id: @user.id }
        @token = JsonWebToken.encode(payload, @exp)

        render "users/show"
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end

    private

    def login_params
      params.permit(:email, :password)
    end
  end
end

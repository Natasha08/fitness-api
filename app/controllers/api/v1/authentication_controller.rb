module API::V1
  class AuthenticationController < APIController
    def login
      render json: User.all.first.to_json
    end
  end
end

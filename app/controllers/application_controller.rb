class ApplicationController < ActionController::API
    before_action :authenticate_token
    private def authenticate_token
      token = request.headers["Authorization"]
      if !token.blank?
        decoded = JWT.decode(token, nil, false)
        user = User.find(decoded["id"])
      end
    rescue ActiveRecord::RecordNotFound
      render(json: {error: "No user found"})
    end
end

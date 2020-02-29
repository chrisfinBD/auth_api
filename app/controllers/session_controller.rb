class SessionController < ApplicationController
 
    skip_before_action :authenticate_token
    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        jwt = JWT.encode(user.as_json, nil, 'none')
        render(json: {token: jwt})
      else
        render(json: {error: "No user found"})
      end
    end
end

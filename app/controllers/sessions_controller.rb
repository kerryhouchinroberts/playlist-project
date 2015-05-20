class SessionsController < ApplicationController

  def new
  end

  def create
    uid = request.env['omniauth.auth']['info']['id']
    session[:user_id] = uid
    user = User.find_or_create_by(oauth_user_id: uid)
    @token = user.update_attributes(token: request.env['omniauth.auth']['credentials']['token'])
    @secret = user.update_attributes(secret: request.env['omniauth.auth']['credentials']['secret'])
    @name = user.update_attributes(name: request.env['omniauth.auth']['info']['display_name'])
    @email = user.update_attributes(email: request.env['omniauth.auth']['info']['email'])
    redirect_to playlists_path
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = "You're now logged out."
    redirect_to root_path
  end
end

class UserServicesController < ApplicationController
  before_action :authenticate_user!, :except => [:create]

  def create
    # Get the service parameter from the Rails router
    service_route = params[:service] ? params[:service] : 'no service (invalid callback)'

    # Get the full hash from omniauth
    omniauth = request.env['omniauth.auth']

    fail Rubbby::Exceptions::OAuth::NoRequestEnvVarFound unless omniauth
    fail Rubbby::Exceptions::OAuth::NoServiceParam       unless params[:service]
    fail Rubbby::Exceptions::OAuth::UserAllreadySignedIn if user_signed_in?

    if service_route == 'github'
      auth = create_for_github(omniauth)
    else
      fail Rubbby::Exceptions::OAuth::UnknownProvider
    end

    flash[:notice] = "Signed in successfully via #{service_route.capitalize}."
    sign_in_and_redirect(:user, auth.user)
  end

  private

    def create_for_github(omniauth)
      oauth_user = {
        email:    omniauth['info']['email'],
        nickname: omniauth['info']['nickname'],
        name:     omniauth['info']['name'],
        uid:      omniauth['uid'],
        token:    omniauth['credentials']['token'],
        provider: omniauth['provider']
      }

      auth = UserService.find_or_create_for(:github, oauth_user)
    end

end
class UserServicesController < ApplicationController
  before_action :authenticate_user!, :except => [:create]

  def create
    # Get the service parameter from the Rails router
    service_route = params[:service] ? params[:service] : 'no service (invalid callback)'

    # Get the full hash from omniauth
    omniauth = request.env['omniauth.auth']

    fail Rubbby::Exceptions::OAuth::NoRequestEnvVarFound unless omniauth
    fail Rubbby::Exceptions::OAuth::NoServiceParam       unless params[:service]

    if service_route == 'github'
      email    = omniauth['info']['email']
      nickname = omniauth['info']['nickname']
      name     = omniauth['info']['name']
      uid      = omniauth['uid']
      token    = omniauth['credentials']['token']
      provider = omniauth['provider']

      fail Rubbby::Exceptions::OAuth::UserAllreadySignedIn if user_signed_in?

      auth = UserService.find_by_provider_and_uid(provider, uid)
      unless auth
        user = User.where(email: email)

        user = (user.any?) ? user : User.new(email: email, password: SecureRandom.hex(10), nickname: nickname, name: name)
        user.services.build(user: user, uid: uid, token: token, provider: provider)
        user.save!

        auth = user.services.last
      end

      flash[:notice] = 'Signed in successfully via ' + provider.capitalize + '.'
      sign_in_and_redirect(:user, auth.user)

    else
      fail Rubbby::Exceptions::OAuth::UnknownProvider
    end
  end

end
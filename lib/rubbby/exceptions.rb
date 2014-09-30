module Rubbby
  module Exceptions
    module Auth
      # When request.env['omniauth.auth'] is not returned
      class NoRequestEnvVarFound < Exception; end

      # When there is no service param
      class NoServiceParamSet < Exception; end

      # When provider is not set or unknown
      class UnknownProvider < Exception; end

      # If user is allready signed in when trying to connect account
      # with github
      class UserAllreadySignedIn < Exception; end
    end
  end
end
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def github
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n#{request.env["omniauth.auth"]}\n\n\n\n\n\n\n\n\n\n\n\n\n"
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
  
end


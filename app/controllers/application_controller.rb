 class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
   # if you have set authenticate_user before protect_from_forgery, your request will result in "Can't verify CSRF token authenticity." 
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    # For nested checkboxes
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit({ roles: [] }, :email, :password, :password_confirmation)
       end
    end
end

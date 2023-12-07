class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_name, if: :user_signed_in?
  before_action :authenticate_user!

  def set_user_name
    @username = current_user.username
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[username])
  end
end

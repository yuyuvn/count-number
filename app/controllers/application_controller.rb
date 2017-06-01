class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def authenticate_user!
    if user_signed_in?
      super
    elsif controller_name != "registrations" && controller_name != "sessions"
      redirect_to new_user_registration_path
    end
  end
end

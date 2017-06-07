class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  #include Mobylette::RespondToMobileRequests
  
  def show
  
  end

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Bitte anmelden."
        redirect_to login_url
      end
    end
end
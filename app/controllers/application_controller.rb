class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :guest_present?, :current_guest

  def guest_present?
    current_guest.present?
  end

  def current_guest
    @current_guest ||= Guest.find_by(id: session[:guest_id])
  end
end

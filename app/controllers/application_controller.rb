class ApplicationController < ActionController::Base
  helper_method :guest_present?, :current_guest

  def guest_present?
    current_guest.present?
  end

  def current_guest
    @current_guest ||= Guest.find_by(id: session[:guest_id])
  end
end

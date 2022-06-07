class ApplicationController < ActionController::Base
  helper_method :guest_present?, :current_guest
  before_action :authenticate_user!, only: :faq

  def guest_present?
    current_guest.present?
  end

  def current_guest
    @current_guest ||= Guest.find_by(id: session[:guest_id])
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :gon_user

  rescue_from CanCan::AccessDenied do |exception|
    format.js   { head :forbidden }
    format.json { head :forbidden }
    format.html { redirect_to root_path, notice: exception.message }
  end

  private

  def gon_user
    gon.is_user_signed_in = user_signed_in?
  end
end

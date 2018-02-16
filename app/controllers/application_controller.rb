class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :gon_user

  private

  def gon_user
    gon.is_user_signed_in = user_signed_in?
  end
end

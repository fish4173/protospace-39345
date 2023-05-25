class ApplicationController < ActionController::Base

  # ログインしていないユーザーをログインページの画面に促すことができます。
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:password,:name,:profile,:occupation,:position])
  end



end

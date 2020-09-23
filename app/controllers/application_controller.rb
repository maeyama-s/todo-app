class ApplicationController < ActionController::Base
  # deviseに関する処理であるときのみ、configure_permitted_parametersメソッドを実行するように設定
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth

  private
  # deviseでログイン機能を実装した場合のパラメーターの受け取り方は通常とは異なる。deviseにおけるparamsのようなメソッド。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end

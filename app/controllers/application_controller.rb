class ApplicationController < ActionController::Base
  # deviseに関する処理であるときのみ、configure_permitted_parametersメソッドを実行するように設定
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # 2021.7/20 Basic認証をなくすためにcomment out
  # before_action :basic_auth

  private

  # deviseでログイン機能を実装した場合のパラメーターの受け取り方は通常とは異なる。deviseにおけるparamsのようなメソッド。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  # 2021.7/20 Basic認証をなくすためにcomment out
  # Basic認証
  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
  #   end
  # end

  # deviseでのログイン後に遷移するパス設定
  def after_sign_in_path_for(_resource)
    tasks_path
  end

  # deviseでのログアウト後に遷移するパス設定
  def after_sign_out_path_for(_resource)
    root_path
  end
end

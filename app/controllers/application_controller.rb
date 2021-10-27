class ApplicationController < ActionController::Base
  before_action :ensure_domain
  before_action :set_locale
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  # end

  private

  # redirect to MYDOMAIN to herokuapp.com
  def ensure_domain
    return unless request.host.match?(/\.herokuapp.com/)

    fqdn = 'www.mizusirazu.net'
    port = ":#{request.port}" unless [80, 443].include?(request.port)  # <---- for the test
    redirect_to "#{request.protocol}#{fqdn}#{port}#{request.path}", status: :moved_permanently
  end

  def set_locale
    I18n.locale = user_locale
  end

  def user_locale
    params[:locale] || session[:locale] || http_head_locale || I18n.default_locale
  end

  def http_head_locale
    http_accept_language.language_region_compatible_from(I18n.available_locales)
  end
end

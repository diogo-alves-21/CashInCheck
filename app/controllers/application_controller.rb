class ApplicationController < ActionController::Base

  include Pundit::Authorization
  include Pagy::Backend

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  def styleguide
    render 'styleguide/index', layout: false
  end

  def set_locale
    if (devise_controller? && resource_name == :admin) || controller_path.include?('admin/')
      I18n.locale = :en
    elsif cookies['locale'].nil? || params[:locale]
      I18n.locale = the_new_locale
      cookies['locale'] = I18n.locale

      redirect_back(fallback_location: root_path) if params.key?(:locale)
    else
      I18n.locale = cookies['locale']
    end
  end

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      if controller_name == 'registrations' && %w[edit update].include?(action_name)
        'mazer'
      else
        'mazer_auth'
      end
    else
      'application'
    end
  end

  def the_new_locale
    new_locale = params[:locale] || extract_locale_from_accept_language_header
    %w[en pt].include?(new_locale) ? new_locale : I18n.default_locale.to_s
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  rescue StandardError
    I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:password, :password_confirmation])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, member_attributes: [:id, :name]])
    #devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, member_attributes: [:id, :name]])
  end

end

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :search_courses

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to root_path, alert: t('words.permission_errors') }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def search_courses
    @courses_header_search = Course.accessible_by(current_ability).ransack(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :name, :formalized_company, person_attributes: [:name, :age]])
  end
end

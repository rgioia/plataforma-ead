class DashboardController < ApplicationController
  def index
    @courses_header_search = Course.accessible_by(current_ability).ransack(params[:q])
    @courses_header_search.sorts = 'name asc' if @courses_header_search.sorts.empty?
    @courses = @courses_header_search.result.paginate(page: params[:page], per_page: 10)
  end
end

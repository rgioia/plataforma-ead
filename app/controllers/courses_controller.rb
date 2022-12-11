class CoursesController < ApplicationController
  load_and_authorize_resource

  before_action :find_course, only: %w(edit update destroy)

  def index
    @q = Course.accessible_by(current_ability).ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @courses = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path, notice: t('notifications.create_record', model: t('models.course.one'))
    else
      render :new
    end
  end

  def edit; end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: t('notifications.update_record', model: t('models.course.one'))
    else
      render :edit
    end
  end

  def destroy
    if @course.destroy
      redirect_to courses_path, notice: t('notifications.remove_record', model: t('models.course.one'))
    else
      redirect_to courses_path, alert: @course.errors.full_messages.to_sentence
    end
  end

  private

  def find_course
    @course = Course.accessible_by(current_ability).find_by(id: params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :start_date, :price, :limit_subscriptions, :photo, :category_id)
  end
end

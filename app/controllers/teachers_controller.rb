class TeachersController < ApplicationController
  load_and_authorize_resource

  before_action :find_teacher, only: %w(edit update destroy)

  def index
    @q = Teacher.accessible_by(current_ability).ransack(params[:q])
    @q.sorts = 'code asc' if @q.sorts.empty?
    @teachers = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    @teacher.person.created_by_administrator = true

    if @teacher.save
      redirect_to teachers_path, notice: t('notifications.create_record', model: t('models.teacher.one'))
    else
      render :new
    end
  end

  def edit; end

  def update
    if @teacher.update(teacher_params)
      redirect_to teachers_path, notice: t('notifications.update_record', model: t('models.teacher.one'))
    else
      render :edit
    end
  end

  def destroy
    if @teacher.destroy
      redirect_to teachers_path, notice: t('notifications.remove_record', model: t('models.teacher.one'))
    else
      redirect_to teachers_path, alert: @teacher.errors.full_messages.to_sentence
    end
  end

  private

  def find_teacher
    @teacher = Teacher.accessible_by(current_ability).find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:code, :active, person_attributes: [:id, :name, :age, user_attributes: [:id, :email]])
  end
end

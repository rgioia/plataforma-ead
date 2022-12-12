class PeopleController < ApplicationController
  load_and_authorize_resource

  before_action :find_person, only: %w(edit update destroy)

  def index
    @q = Person.not_teachers.accessible_by(current_ability).ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @people = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params.merge(created_by_administrator: true))
    if @person.save
      redirect_to people_path, notice: t('notifications.create_record', model: t('models.person.one'))
    else
      render :new
    end
  end

  def edit; end

  def update
    if @person.update(person_params)
      redirect_to people_path, notice: t('notifications.update_record', model: t('models.person.one'))
    else
      render :edit
    end
  end

  def destroy
    if @person.destroy
      redirect_to people_path, notice: t('notifications.remove_record', model: t('models.person.one'))
    else
      redirect_to people_path, alert: @person.errors.full_messages.to_sentence
    end
  end

  private

  def find_person
    @person = Person.accessible_by(current_ability).find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :age, user_attributes: [:id, :email])
  end
end

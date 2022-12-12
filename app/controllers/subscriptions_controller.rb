class SubscriptionsController < ApplicationController
  load_and_authorize_resource

  before_action :find_subscription, only: %w(edit update destroy)
  before_action :find_course, only: %w(new create)

  def index
    @q = Subscription.accessible_by(current_ability).ransack(params[:q])
    # @q.sorts = 'name asc' if @q.sorts.empty?
    @subscriptions = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @subscription = @course.subscriptions.build(person: current_user.person)
  end

  def create
    @subscription = @course.subscriptions.build(subscription_params.merge(person: current_user.person))
    if @subscription.save
      redirect_to root_path, notice: t('notifications.create_record', model: t('models.course.one'))
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
    @course = Course.accessible_by(current_ability).find(params[:course_id])
  end

  def find_subscription
    @subscription = Subscription.accessible_by(current_ability).find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:form_of_payment)
  end
end

class CategoriesController < ApplicationController
  load_and_authorize_resource

  before_action :find_category, only: %w(edit update destroy)

  def index
    @q = Category.accessible_by(current_ability).ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @categories = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: t('notifications.create_record', model: t('models.category.one'))
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: t('notifications.update_record', model: t('models.category.one'))
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: t('notifications.remove_record', model: t('models.category.one'))
    else
      redirect_to categories_path, alert: @category.errors.full_messages.to_sentence
    end
  end

  private

  def find_category
    @category = Category.accessible_by(current_ability).find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

class Activity::CategoriesController < ApplicationController
  before_action :set_activity_category, only: %i[ show edit update destroy ]

  def index
    @activity_categories = Activity::Category.all
  end

  def show
  end

  def new
    @activity_category = Activity::Category.new
  end

  def edit
  end

  def create
    @activity_category = Activity::Category.new(activity_category_params)

    respond_to do |format|
      if @activity_category.save
        format.html { redirect_to @activity_category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @activity_category }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @activity_category.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @activity_category.update(activity_category_params)
        format.html { redirect_to @activity_category, notice: "Category was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @activity_category }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @activity_category.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @activity_category.destroy!

    respond_to do |format|
      format.html { redirect_to activity_categories_path, notice: "Category was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_activity_category
      @activity_category = Activity::Category.find(params.expect(:id))
    end

    def activity_category_params
      params.expect(activity_category: [ :label, :user_id ])
    end
end

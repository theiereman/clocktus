class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]

  def index
    @activities = Activity.all
  end

  def show
  end

  def new
    @activity = Activity.new
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: "Activity was successfully created." }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @activity.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: "Activity was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @activity.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @activity.destroy!

    respond_to do |format|
      format.html { redirect_to activities_path, notice: "Activity was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_activity
      @activity = Activity.find(params.expect(:id))
    end

    def activity_params
      params.expect(activity: [ :started_at, :ended_at, :category_id ])
    end
end

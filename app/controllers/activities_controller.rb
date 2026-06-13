class ActivitiesController < ApplicationController
  before_action :set_time
  before_action :set_categories, only: :index

  def index
  end

  def create
    @activity = Activity.new(activity_params)

    @activity.started_at = DateTime.new(@day.year, @day.month, @day.day, @hour)
    @activity.ended_at = @activity.started_at + 1.hour

    if @activity.save
      redirect_to activities_path
    else
      redirect_to activities_path, alert: @activity.errors.full_messages.first
    end
  end

  private

  def set_categories
    @categories = Current.user.activity_categories
  end

  def set_time
    @day = Date.current
    @hour = Current.user.latest_activity_for(@day)&.ended_at&.hour || Current.user.wake_up_hour
  end

  def activity_params
    params.expect(activity: [ :activity_category_id ])
  end
end

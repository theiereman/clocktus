class Activity::CategoriesController < ApplicationController
  before_action :set_activity_category, only: %i[ update destroy ]

  def create
    @activity_category = Current.user.activity_categories.new(activity_category_params)

    if @activity_category.save
      redirect_to settings_path, notice: t("activity.categories.flash.created")
    else
      redirect_to settings_path, alert: @activity_category.errors.full_messages.first
    end
  end

  def update
    if @activity_category.update(activity_category_params)
      redirect_to settings_path, notice: t("activity.categories.flash.updated")
    else
      redirect_to settings_path, alert: @activity_category.errors.full_messages.first
    end
  end

  def destroy
    if @activity_category.activities.any?
      render turbo_stream: turbo_stream.update(:modals, partial: "activities/categories/transfer_activities_modal", locals: { category: @activity_category })
      return
    end

    @activity_category.destroy!
    redirect_to settings_path, notice: t("activity.categories.flash.destroyed")
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to settings_path, alert: t("activity.categories.flash.destroy_failed")
  end

  private

  def set_activity_category
    @activity_category = Current.user.activity_categories.find(params.expect(:id))
  end

  def activity_category_params
    params.expect(activity_category: [ :label, :color ])
  end
end

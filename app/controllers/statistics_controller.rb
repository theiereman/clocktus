class StatisticsController < ApplicationController
  def show
    activities = Current.user.activities
    presenter = ActivitiesPerCategoryPresenter.new(activities)
    @count_per_category = presenter.present
    @top_categories = presenter.top_table
    @hours_per_category_over_time = HoursPerCategoryPresenter.present(activities)
  end
end

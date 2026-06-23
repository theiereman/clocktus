class StatisticsController < ApplicationController
  def show
    categories = Current.user.activity_categories.order(:label).index_by(&:label)
    @colors = categories.map { |_, data| data.color }

    activities = Current.user.activities
    @count_per_category = ActivitiesPerCategoryPresenter.present(activities)
    @hours_per_category_over_time = HoursPerCategoryPresenter.present(activities)
  end
end

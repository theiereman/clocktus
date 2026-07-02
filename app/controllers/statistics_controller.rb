class StatisticsController < ApplicationController
  include StatisticsPresentable
  include Statistics::Searchable

  def show
    @shareable = true
    user = Current.user
    present_statistics_for(user, filtered_activities(user))
  end
end

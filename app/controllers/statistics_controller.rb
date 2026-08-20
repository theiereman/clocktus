class StatisticsController < ApplicationController
  include StatisticsPresentable
  include Statistics::Searchable

  def show
    @shareable = true
    user = Current.user
    present_activities_statistics_for(user, filtered_activities(user))
    present_mood_statistics_for(user, filtered_moods(user))
    present_global_statistics_for(user)
  end
end

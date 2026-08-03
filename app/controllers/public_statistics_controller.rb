class PublicStatisticsController < ApplicationController
  include StatisticsPresentable
  include Statistics::Searchable

  allow_unauthenticated_access only: :show
  layout "public"

  def show
    user = UserProfileLink.find_by!(token: params[:token]).user
    present_global_statistics_for(user)
    present_activities_statistics_for(user, filtered_activities(user))
    render "statistics/show"
  end
end

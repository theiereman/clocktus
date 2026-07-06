module Statistics::Searchable
  extend ActiveSupport::Concern

  def filtered_activities(user)
    set_filter_values(user)

    progress = User::Progress.between(user, @from, @to)
    activities = progress.activities
    return activities unless @full_days_only

    complete_days = activities
      .map { |activity| activity.started_at.to_date }
      .uniq
      .select { |day| progress.all_activities_done?(date: day) }
      .to_set

    activities.select { |activity| complete_days.include?(activity.started_at.to_date) }
  end

  private

  def set_filter_values(user)
    @from = params[:from]&.to_date || user.activities.minimum(:started_at)&.to_date || Date.current
    @to = params[:to]&.to_date || user.activities.maximum(:started_at)&.to_date || Date.current
    @full_days_only = ActiveModel::Type::Boolean.new.cast(params[:full_days_only])
  end
end

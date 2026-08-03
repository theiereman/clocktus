module Statistics::Searchable
  extend ActiveSupport::Concern

  included do
    helper_method :single_day?
    helper_method :filtered_on_today?
    helper_method :filtered_on_week?
    helper_method :filtered_on_month?
    helper_method :filtered_on_year?
  end

  def filtered_activities(user)
    @from = params[:from]&.to_date || user.activities.minimum(:started_at)&.to_date || Date.current
    @to = params[:to]&.to_date || user.activities.maximum(:started_at)&.to_date || Date.current

    progress = User::Progress.between(user, @from, @to).activities
  end

  def single_day?
    @from == @to
  end

  def filtered_on_today?
    @from == Date.current && @to == Date.current
  end


  def filtered_on_week?
    @from == Date.current.beginning_of_week && @to == Date.current.end_of_week
  end

  def filtered_on_month?
    @from == Date.current.beginning_of_month && @to == Date.current.end_of_month
  end

  def filtered_on_year?
    @from == Date.current.beginning_of_year && @to == Date.current.end_of_year
  end
end

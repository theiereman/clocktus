module StatisticsHelper
  def year_select_values
    first_activity = Current.user&.activities&.order(started_at: :asc)&.first
    last_activity = Current.user&.activities&.order(started_at: :desc)&.first

    res = []
    res << [ t("statistics.show.filters.all_years"), nil ]
    res + (first_activity.started_at.year..last_activity.started_at.year).to_a.map do |year|
      [ year, year ]
    end
  end
end

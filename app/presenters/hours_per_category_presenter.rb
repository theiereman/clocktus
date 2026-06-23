class HoursPerCategoryPresenter
  def self.present(activities)
    new(activities).present
  end

  def initialize(activities)
    @activities = activities
  end

  def present
    hours_by_category_and_date.map do |category, data|
      {
        name: category.label,
        data: all_dates.index_with { |d| data[d]&.size || 0 },
        color: category.color
      }
    end
  end

  private

  def all_dates
    hours_by_category_and_date.values.flat_map(&:keys).uniq.sort
  end

  def hours_by_category_and_date
    @cache ||= @activities
      .includes(:category)
      .group_by { |a| [ a.category, a.started_at.to_date ] }
      .each_with_object(Hash.new { |h, k| h[k] = {} }) do |(key, acts), hash|
        category, date = key
        hash[category][date] = acts
      end
  end
end

class ActivitiesPerCategoryPresenter
  def self.present(activities)
    new(activities).present
  end

  def initialize(activities)
    @activities = activities
  end

  def present
    sorted.map { |(label, color), count| { name: label, data: { label => count }, color: color } }
  end

  def top_table(limit: 10)
    total = sorted.sum { |_, count| count }
    sorted.first(limit).map do |(label, color), count|
      { label: label, color: color, count: count, percentage: total > 0 ? (count.to_f / total * 100).round(1) : 0 }
    end
  end

  private

  def sorted
    @sorted ||= count_by_label_and_color.sort_by { |_, count| -count }
  end

  def count_by_label_and_color
    @cache ||= @activities
      .joins(:category)
      .group("activity_categories.label", "activity_categories.color")
      .count
  end
end

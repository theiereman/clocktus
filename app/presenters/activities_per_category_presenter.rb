class ActivitiesPerCategoryPresenter
  def self.present(activities)
    new(activities).present
  end

  def initialize(activities)
    @activities = activities
  end

  def present
    categories.each_with_object({}) do |cat, h|
      h[cat] = count_by_label[cat] || 0
    end
  end

  private

  def categories = count_by_label.keys

  def count_by_label
     @h_cache ||= @activities
      .joins(:category)
      .group("activity_categories.label")
      .count
  end
end

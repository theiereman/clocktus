class DailyProgressPresenter
  delegate_missing_to :@progress # views methods calls

  Slot = Data.define(:starts_at, :activity, :night) do
    def hour = starts_at.hour
    def filled? = activity.present?
    def label = filled? ? activity.category.label : I18n.t("activities.slot.empty")
  end

  def initialize(progress)
    @progress = progress
  end

  def slots
    @progress.slots_for(@progress.range.first.to_date).map do |starts_at, activity|
      Slot.new(starts_at: starts_at, activity: activity, night: @progress.user.night?(starts_at.hour))
    end
  end

  private
end

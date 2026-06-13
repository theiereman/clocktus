class Activity < ApplicationRecord
  belongs_to :category, class_name: "Activity::Category", foreign_key: "activity_category_id"
  has_one :user, through: :category

  validate :user_has_not_finished_day

  scope :today, -> { where(started_at: Time.current.beginning_of_day..Time.current.end_of_day) }

  def duration_in_hours
    ((ended_at - started_at) / 1.hour).round(2)
  end

  private

  def user_has_not_finished_day
    return true unless user.has_done_every_activity_for(started_at.to_date)

    errors.add(:base, "L'utilisateur a déjà rempli tous les activités pour aujourd'hui")
    false
  end
end

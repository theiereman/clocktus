class User < ApplicationRecord
  include User::MagicLinkable
  include User::Setupable

  has_many :activity_categories, class_name: "Activity::Category", dependent: :destroy
  has_many :activities
  has_one :user_profile_link, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_create -> { Activity::Category.create_default_categories_for(self) }

  accepts_nested_attributes_for :activity_categories

  def fill_slot(started_at, activity_category_id:)
    started_at = snap_to_activity_slot(started_at)
    ended_at = started_at + activity_duration_in_minutes.minutes
    activity = activities.new(started_at:, ended_at:, activity_category_id:)

    transaction do
      activities.overlapping(started_at, ended_at).destroy_all
      activity.save!
    end
    activity
  rescue ActiveRecord::RecordInvalid
    activity
  end

  def last_activity(day)
    activities.where(started_at: day.beginning_of_day...day.end_of_day).order(started_at: :desc).first
  end

  def wake_up_datetime(date: Date.current)
    Time.zone.local(date.year, date.month, date.day, wake_up_hour)
  end
end

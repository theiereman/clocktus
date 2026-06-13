class User < ApplicationRecord
  include User::MagicLinkable

  has_many :sessions, dependent: :destroy
  has_many :activity_categories, class_name: "Activity::Category", dependent: :destroy
  has_many :activities, through: :activity_categories

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true,
  format: { with: URI::MailTo::EMAIL_REGEXP }

  def latest_activity_for(date)
    activities.select { |activity| activity.started_at.to_date == date }.max_by(&:started_at)
  end

  def has_done_every_activity_for(date)
    remaining_activities_for(date) == 0
  end

  def remaining_activities_for(date)
    total_number_of_activities_in_a_day - number_of_activities_for(date)
  end

  def total_number_of_activities_in_a_day
    awake_duration_in_hours / activity_duration_in_hours
  end

  def number_of_activities_for(date)
    activities.select { |activity| activity.started_at.to_date == date }.count
  end

  def remaining_hours_for(date)
    hours = 24 - sleep_duration_in_hours - activities.select { |activity| activity.started_at.to_date == date }.sum(&:duration_in_hours)
    hours % 1 == 0 ? hours.to_i : hours
  end

  def wake_up_hour = 7
  def sleep_hour = 23
  def awake_duration_in_hours = sleep_hour - wake_up_hour
  def sleep_duration_in_hours = 24 - awake_duration_in_hours
  def activity_duration_in_hours = 1
end

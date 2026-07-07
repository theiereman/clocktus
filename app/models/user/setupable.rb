module User::Setupable
  extend ActiveSupport::Concern

  DEFAULT_WAKE_UP_HOUR = 7
  DEFAULT_SLEEP_HOUR = 23

  AVAILABLE_ACTIVITY_DURATIONS = [ 15, 30, 60 ]

  REMINDER_FREQUENCIES = %w[daily weekly monthly]
  DEFAULT_REMINDER_FREQUENCY = "daily"
  DEFAULT_REMINDER_HOUR = 18

  included do
    before_validation :set_default_values

    store :settings, accessors: [ :sleep_hour, :wake_up_hour, :locale, :activity_duration_in_minutes, :reminder_enabled, :reminder_frequency, :reminder_hour ]

    validates :activity_duration_in_minutes, inclusion: { in: AVAILABLE_ACTIVITY_DURATIONS }
    validates :reminder_frequency, inclusion: { in: REMINDER_FREQUENCIES }, if: :reminder_enabled?
    validates :reminder_hour, inclusion: { in: 0..23 }, if: :reminder_enabled?

    def wake_up_hour = super.to_i
    def sleep_hour = super.to_i

    def night?(hour)
      if sleep_hour < wake_up_hour
        hour > sleep_hour && hour < wake_up_hour
      else
        hour > sleep_hour || hour < wake_up_hour
      end
    end

    def sleep_hours
      24.times.select { night?(it) }
    end

    def activity_duration_in_minutes
      (super || 60).to_i
    end

    def snap_to_activity_slot(time)
      index = ((time - time.beginning_of_day) / 60 / activity_duration_in_minutes).floor
      time.beginning_of_day + (index * activity_duration_in_minutes).minutes
    end

    def reminder_enabled?
      ActiveModel::Type::Boolean.new.cast(reminder_enabled)
    end

    def reminder_frequency
      super.presence || DEFAULT_REMINDER_FREQUENCY
    end

    def reminder_hour
      (super || DEFAULT_REMINDER_HOUR).to_i
    end

    def reminder_due?(time = Time.current)
      return false unless reminder_enabled?
      return false unless reminder_hour == time.hour

      case reminder_frequency
      when "daily" then true
      when "weekly" then time.monday?
      when "monthly" then time.day == 1
      else false
      end
    end

    private

    def set_default_values
      return if sleep_schedule_setup?

      self.wake_up_hour = DEFAULT_WAKE_UP_HOUR
      self.sleep_hour = DEFAULT_SLEEP_HOUR
    end

    def sleep_schedule_setup?
      !self.wake_up_hour.zero? && !self.sleep_hour.zero?
    end
  end
end

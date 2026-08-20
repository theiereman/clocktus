module StatisticsPresentable
  extend ActiveSupport::Concern

  private

    def present_global_statistics_for(user)
      @user_signup_date = user.created_at.to_date
      @number_of_dates_since_user_signup = (Date.current - user.created_at.to_date).to_i
      @number_of_activities = user.activities.count
      @days_completed = User::Progress.since_start(user).number_of_days_completed
    end

    def present_activities_statistics_for(user, activities)
      presenter = ActivitiesPerCategoryPresenter.new(activities)
      @count_per_category = presenter.present
      @top_categories = presenter.top_table
      @hours_per_category_over_time = HoursPerCategoryPresenter.present(activities)
    end

    def present_mood_statistics_for(user, moods)
      @mood_over_time = MoodOverTimePresenter.present(moods)
      @mood_level_labels = Mood.levels.sort_by { |_, value| value }.map { |level, _| t("activities.mood_form.levels.#{level}") }
    end
end

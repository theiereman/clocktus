class Day
  attr_reader :date, :number_of_remaining_activities, :number_of_remaining_activities

  def initialize(date, completed, activities_in_a_day_count, remaining_activities_count)
    @date = date
    @completed = completed
    @activities_in_a_day_count = activities_in_a_day_count
    @remaining_activities_count = remaining_activities_count
  end

  def activities_done_count
    @activities_in_a_day_count - @remaining_activities_count
  end

  def percentage_done
    return 0 if @activities_in_a_day_count == 0
    (activities_done_count.to_f / @activities_in_a_day_count * 100).round
  end

  def completed? = @completed
end

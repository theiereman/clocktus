class Day
  attr_reader :date, :mood

  def initialize(date, filled_slots, total_slots, mood = nil)
    @date = date
    @filled_slots = filled_slots
    @total_slots = total_slots
    @mood = mood
  end

  def percentage_done
    return 0 if @total_slots.zero?
    
    (@filled_slots.to_f / @total_slots * 100).round
  end

  def completed? = @filled_slots >= @total_slots
end

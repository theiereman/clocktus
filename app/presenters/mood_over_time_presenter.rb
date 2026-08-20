class MoodOverTimePresenter
  def self.present(moods)
    new(moods).present
  end

  def initialize(moods)
    @moods = moods
  end

  def present
    @moods.each_with_object({}) { |mood, data| data[mood.date] = Mood.levels[mood.level] }
  end
end

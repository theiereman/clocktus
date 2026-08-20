module MoodHelper
  MOOD_ICONS = {
    "great" => "laugh",
    "good" => "smile",
    "mid" => "meh",
    "bad" => "frown",
    "terrible" => "angry"
  }.freeze

  def mood_icon_for(level)
    MOOD_ICONS.fetch(level.to_s)
  end
end

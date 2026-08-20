require "test_helper"

class MoodOverTimePresenterTest < ActiveSupport::TestCase
  test "maps each mood to its numeric level, keyed by date" do
    user = users(:one)
    great = Mood.create!(user: user, date: Date.new(2026, 6, 10), level: :great)
    terrible = Mood.create!(user: user, date: Date.new(2026, 6, 12), level: :terrible)

    data = MoodOverTimePresenter.present(Mood.where(id: [ great.id, terrible.id ]).order(:date))

    assert_equal({ great.date => Mood.levels["great"], terrible.date => Mood.levels["terrible"] }, data)
  end

  test "returns an empty hash when there are no moods" do
    assert_equal({}, MoodOverTimePresenter.present(Mood.none))
  end
end

class Mood < ApplicationRecord
  enum :level, [ :terrible, :bad, :mid, :good, :great ]

  belongs_to :user

  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :level, presence: true
end

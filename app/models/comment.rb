class Comment < ApplicationRecord
  belongs_to :user

  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :body, presence: true

  def self.find_or_initialize_for(user, date)
    user.comments.find_or_initialize_by(date: date)
  end
end

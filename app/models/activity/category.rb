class Activity::Category < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :restrict_with_error
end

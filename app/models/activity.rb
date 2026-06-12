class Activity < ApplicationRecord
  belongs_to :category, class_name: "Activity::Category", foreign_key: "activity_category_id"
  has_one :user, through: :category
end

class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.belongs_to :activity_category, null: false, foreign_key: true
      t.timestamps
    end
  end
end

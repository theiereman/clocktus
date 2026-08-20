class CreateMoods < ActiveRecord::Migration[8.0]
  def change
    create_table :moods do |t|
      t.date :date
      t.integer :level
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

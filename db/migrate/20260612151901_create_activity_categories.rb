class CreateActivityCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :activity_categories do |t|
      t.string :label
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

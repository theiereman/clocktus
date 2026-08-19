class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.text :body, null: false
      t.timestamps
    end
    add_index :comments, [ :user_id, :date ], unique: true
  end
end

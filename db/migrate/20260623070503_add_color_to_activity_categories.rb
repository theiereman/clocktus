class AddColorToActivityCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :activity_categories, :color, :string, default: "#6b7280"
  end
end

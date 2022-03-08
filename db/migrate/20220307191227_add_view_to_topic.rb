class AddViewToTopic < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :view, :integer
  end
end

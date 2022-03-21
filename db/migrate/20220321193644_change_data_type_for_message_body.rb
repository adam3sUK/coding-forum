class ChangeDataTypeForMessageBody < ActiveRecord::Migration[7.0]
  def up
    change_column :messages, :body, :text
  end

  def down
    change_column :messages, :body, :string
  end
end

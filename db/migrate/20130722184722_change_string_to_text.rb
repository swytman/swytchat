class ChangeStringToText < ActiveRecord::Migration
  def up
    change_column :messages, :content, :text
end
def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :messages, :content, :string
end
end

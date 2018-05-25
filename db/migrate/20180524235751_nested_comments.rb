class NestedComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :parent_comment_id, :integer
  end
end

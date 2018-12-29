class AddIsStickyToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :is_sticky, :bool, default: false
  end
end

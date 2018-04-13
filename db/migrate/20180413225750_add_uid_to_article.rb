class AddUidToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :uid, :string
    add_index :articles, :uid
  end
end

class AddKarmaToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :karma, :integer, default: 0
  end
end

class AddSlugToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :slug, :string
  end
end

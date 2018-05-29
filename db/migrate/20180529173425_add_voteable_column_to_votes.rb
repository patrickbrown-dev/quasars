class AddVoteableColumnToVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :karma, :integer, default: 0

    add_column :votes, :voteable_id, :int
    add_column :votes, :voteable_type, :string

    add_index :votes, [:voteable_type, :voteable_id]

    remove_column :votes, :article_id
  end
end

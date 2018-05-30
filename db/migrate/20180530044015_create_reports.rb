class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.text :description
      t.references :user
      t.references :reportable, polymorphic: true, index: true
      t.datetime :resolved_at

      t.timestamps
    end
  end
end

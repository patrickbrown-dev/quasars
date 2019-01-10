class AddEmailNotificationsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email_notifications, :bool, default: true
  end
end

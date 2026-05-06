class CreateFollowRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :follow_requests do |t|
      t.string :status
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
  end
end

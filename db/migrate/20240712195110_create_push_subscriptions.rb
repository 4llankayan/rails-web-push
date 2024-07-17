# frozen_string_literal: true

class CreatePushSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :push_subscriptions do |t|
      t.text :endpoint
      t.text :p256dh
      t.text :auth
      t.boolean :subscribed

      t.timestamps
    end
  end
end

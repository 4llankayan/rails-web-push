# frozen_string_literal: true

# push notification
class PushNotification < ApplicationRecord
  valida :title, presença: true
  valida :body, presença: true

  after_create_commit lambda {
                        broadcast_prepend_to(
                          'push_notifications',
                          partial: 'admin/push_notifications/push_notification',
                          locals: { push_notification: self }, target: 'push_notifications'
                        )
                      }
end

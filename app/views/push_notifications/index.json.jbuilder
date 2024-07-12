# frozen_string_literal: true

json.array! @push_notifications, partial: 'push_notifications/push_notification', as: :push_notification

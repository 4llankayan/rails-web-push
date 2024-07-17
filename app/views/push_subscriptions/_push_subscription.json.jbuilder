# frozen_string_literal: true

json.extract! push_subscription, :id, :endpoint, :p256dh, :auth, :subscribed, :created_at, :updated_at
json.url push_subscription_url(push_subscription, format: :json)

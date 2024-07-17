# frozen_string_literal: true

require 'test_helper'

class PushSubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @push_subscription = push_subscriptions(:one)
  end

  test 'should get index' do
    get push_subscriptions_url
    assert_response :success
  end

  test 'should get new' do
    get new_push_subscription_url
    assert_response :success
  end

  test 'should create push_subscription' do
    assert_difference('PushSubscription.count') do
      post push_subscriptions_url,
           params: { push_subscription: { auth: @push_subscription.auth, endpoint: @push_subscription.endpoint,
                                          p256dh: @push_subscription.p256dh, subscribed: @push_subscription.subscribed } }
    end

    assert_redirected_to push_subscription_url(PushSubscription.last)
  end

  test 'should show push_subscription' do
    get push_subscription_url(@push_subscription)
    assert_response :success
  end

  test 'should get edit' do
    get edit_push_subscription_url(@push_subscription)
    assert_response :success
  end

  test 'should update push_subscription' do
    patch push_subscription_url(@push_subscription),
          params: { push_subscription: { auth: @push_subscription.auth, endpoint: @push_subscription.endpoint,
                                         p256dh: @push_subscription.p256dh, subscribed: @push_subscription.subscribed } }
    assert_redirected_to push_subscription_url(@push_subscription)
  end

  test 'should destroy push_subscription' do
    assert_difference('PushSubscription.count', -1) do
      delete push_subscription_url(@push_subscription)
    end

    assert_redirected_to push_subscriptions_url
  end
end

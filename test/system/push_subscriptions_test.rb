require "application_system_test_case"

class PushSubscriptionsTest < ApplicationSystemTestCase
  setup do
    @push_subscription = push_subscriptions(:one)
  end

  test "visiting the index" do
    visit push_subscriptions_url
    assert_selector "h1", text: "Push subscriptions"
  end

  test "should create push subscription" do
    visit push_subscriptions_url
    click_on "New push subscription"

    fill_in "Auth", with: @push_subscription.auth
    fill_in "Endpoint", with: @push_subscription.endpoint
    fill_in "P256dh", with: @push_subscription.p256dh
    check "Subscribed" if @push_subscription.subscribed
    click_on "Create Push subscription"

    assert_text "Push subscription was successfully created"
    click_on "Back"
  end

  test "should update Push subscription" do
    visit push_subscription_url(@push_subscription)
    click_on "Edit this push subscription", match: :first

    fill_in "Auth", with: @push_subscription.auth
    fill_in "Endpoint", with: @push_subscription.endpoint
    fill_in "P256dh", with: @push_subscription.p256dh
    check "Subscribed" if @push_subscription.subscribed
    click_on "Update Push subscription"

    assert_text "Push subscription was successfully updated"
    click_on "Back"
  end

  test "should destroy Push subscription" do
    visit push_subscription_url(@push_subscription)
    click_on "Destroy this push subscription", match: :first

    assert_text "Push subscription was successfully destroyed"
  end
end

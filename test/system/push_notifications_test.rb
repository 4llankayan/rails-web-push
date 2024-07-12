require "application_system_test_case"

class PushNotificationsTest < ApplicationSystemTestCase
  setup do
    @push_notification = push_notifications(:one)
  end

  test "visiting the index" do
    visit push_notifications_url
    assert_selector "h1", text: "Push notifications"
  end

  test "should create push notification" do
    visit push_notifications_url
    click_on "New push notification"

    fill_in "Body", with: @push_notification.body
    fill_in "Title", with: @push_notification.title
    click_on "Create Push notification"

    assert_text "Push notification was successfully created"
    click_on "Back"
  end

  test "should update Push notification" do
    visit push_notification_url(@push_notification)
    click_on "Edit this push notification", match: :first

    fill_in "Body", with: @push_notification.body
    fill_in "Title", with: @push_notification.title
    click_on "Update Push notification"

    assert_text "Push notification was successfully updated"
    click_on "Back"
  end

  test "should destroy Push notification" do
    visit push_notification_url(@push_notification)
    click_on "Destroy this push notification", match: :first

    assert_text "Push notification was successfully destroyed"
  end
end

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
   setup do
    @user = users(:one)
    sign_in(@user)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Address", with: @user.address
    fill_in "City", with: @user.city
    fill_in "Email", with: Faker::Internet.email
    fill_in "First name", with: @user.first_name
    fill_in "Last name", with: @user.last_name
    fill_in "Phone", with: @user.phone
    select('Iowa', from: 'State')
    fill_in "Zip", with: @user.zip
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end
end

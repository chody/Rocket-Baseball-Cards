require "application_system_test_case"

class CardsTest < ApplicationSystemTestCase
  setup do
    @card = cards(:one)
    @user = users(:one)
    sign_in(@user)
  end

  test "visiting the index" do
    visit cards_url
    assert_selector "h1", text: "Cards"
  end

  test "creating a Card" do
    visit cards_url
    click_on "New Card"

    fill_in "Manufacturer", with: @card.manufacturer
    fill_in "Player first name", with: @card.player_first_name
    fill_in "Player last name", with: @card.player_last_name
    fill_in "Series number", with: @card.series_number
    fill_in "User", with: @card.user_id
    fill_in "Year", with: @card.year
    click_on "Create Card"

    assert_text "Card was successfully created"
    click_on "Back"
  end

  test "updating a Card" do
    visit cards_url
    click_on "Edit", match: :first

    fill_in "Manufacturer", with: @card.manufacturer
    fill_in "Player first name", with: @card.player_first_name
    fill_in "Player last name", with: @card.player_last_name
    fill_in "Series number", with: @card.series_number
    fill_in "User", with: @card.user_id
    fill_in "Year", with: @card.year
    click_on "Update Card"

    assert_text "Card was successfully updated"
    click_on "Back"
  end

  test "destroying a Card" do
    visit cards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Card was successfully destroyed"
  end
end

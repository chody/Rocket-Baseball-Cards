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

    select('Topps', from: 'Manufacturer')
    fill_in "Player First Name", with: @card.player_first_name
    fill_in "Player Last Name", with: @card.player_last_name
    fill_in "Series Number", with: @card.series_number
    fill_in "Year", with: @card.year
    click_on "Create Card"

    assert_text "Card was successfully created"
    click_on "Back"
  end

  test "updating a Card" do
    visit cards_url
    click_on "Edit", match: :first

    select('Topps', from: 'Manufacturer')
    fill_in "Player First Name", with: @card.player_first_name
    fill_in "Player Last Name", with: @card.player_last_name
    fill_in "Series Number", with: @card.series_number
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

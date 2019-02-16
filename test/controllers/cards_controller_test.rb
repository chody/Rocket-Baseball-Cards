require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card = cards(:one)
    @user = users(:one)
    sign_in(@user)
  end

  test "should get index" do
    get cards_url
    assert_response :success
  end

  test "should get new" do
    get new_card_url
    assert_response :success
  end

  test "should create card" do
    assert_difference('Card.count') do
      post cards_url, params: { card: { manufacturer: @card.manufacturer, player_first_name: @card.player_first_name, player_last_name: @card.player_last_name, series_number: @card.series_number, user_id: @card.user_id, year: @card.year } }
    end

    assert_redirected_to card_url(Card.last)
  end

  test "should show card" do
    get card_url(@card)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_url(@card)
    assert_response :success
  end

  test "should update card" do
    patch card_url(@card), params: { card: { manufacturer: @card.manufacturer, player_first_name: @card.player_first_name, player_last_name: @card.player_last_name, series_number: @card.series_number, user_id: @card.user_id, year: @card.year } }
    assert_redirected_to card_url(@card)
  end

  test "should destroy card" do
    assert_difference('Card.count', -1) do
      delete card_url(@card)
    end

    assert_redirected_to cards_url
  end
end

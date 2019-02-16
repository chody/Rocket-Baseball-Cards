require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in(@user)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { address: @user.address, city: @user.city, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, phone: @user.phone, state: @user.state, zip: @user.zip } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end

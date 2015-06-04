require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "a logged in user should be able to edit their user profile" do
    sign_in users(:user)
    get :edit

    assert_response :success
  end

  test "a logged in user should be able to update their user profile" do
    @user = users(:user)
    sign_in @user
    assert_difference 'User.find(2).name.length', -3 do
      patch :update, { id: @user.id, user: {name: 'something', current_password: '12345678'} }
      assert User.find(2).name == 'something', "name does not update"
    end
    assert_redirected_to root_path

  end

  test "a signed in user should NOT be able to change their admin or active status" do
    sign_in users(:user)

    patch :update, { id: 2, user: {admin: true, current_password: '12345678'} }
    assert users(:user).admin == false

    assert_redirected_to root_path

  end

end
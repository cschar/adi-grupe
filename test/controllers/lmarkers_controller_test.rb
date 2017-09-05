require 'test_helper'

class LmarkersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lmarker = lmarkers(:one)
    @user = users(:one)
    @lmarker.user_id = @user.id
  end

  test "should get index" do
    get lmarkers_url
    assert_response :success
  end

  test "should get new" do
    get new_lmarker_url
    assert_response :success
  end

  test "should create lmarker" do
    assert_difference('Lmarker.count') do
      post lmarkers_url, params: { lmarker: { lat: @lmarker.lat, lng: @lmarker.lng, ltype: @lmarker.ltype, user_id: @lmarker.user_id } }
    end

    assert_redirected_to lmarker_url(Lmarker.last)
  end

  test "should show lmarker" do
    get lmarker_url(@lmarker)
    assert_response :success
  end

  test "should get edit" do
    get edit_lmarker_url(@lmarker)
    assert_response :success
  end

  test "should update lmarker" do
    patch lmarker_url(@lmarker),
          params: { lmarker: { lat: @lmarker.lat, lng: @lmarker.lng, ltype: @lmarker.ltype, user_id: @lmarker.user_id } }
    assert_redirected_to lmarker_url(@lmarker)
  end

  test "should destroy lmarker" do
    assert_difference('Lmarker.count', -1) do
      delete lmarker_url(@lmarker)
    end

    assert_redirected_to lmarkers_url
  end
end

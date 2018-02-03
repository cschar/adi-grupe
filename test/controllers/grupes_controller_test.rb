require 'test_helper'

class GrupesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grupe = grupes(:one)
  end

  test "should get index" do
    get grupes_url
    assert_response :success
  end

  test "should get new" do
    get new_grupe_url
    assert_response :success
  end

  test "should create grupe" do
    assert_difference('Grupe.count') do
      post grupes_url, params: { grupe: { location_id: @grupe.location_id, name: @grupe.name } }
    end

    assert_redirected_to grupe_url(Grupe.last)
  end

  test "should show grupe" do
    get grupe_url(@grupe)
    assert_response :success
  end

  test "should get edit" do
    get edit_grupe_url(@grupe)
    assert_response :success
  end

  test "should update grupe" do
    patch grupe_url(@grupe), params: { grupe: { location_id: @grupe.location_id, name: @grupe.name } }
    assert_redirected_to grupe_url(@grupe)
  end

  test "should destroy grupe" do
    assert_difference('Grupe.count', -1) do
      delete grupe_url(@grupe)
    end

    assert_redirected_to grupes_url
  end
end

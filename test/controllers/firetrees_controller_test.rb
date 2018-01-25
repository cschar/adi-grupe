require 'test_helper'

class FiretreesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @firetree = firetrees(:one)
  end

  test "should get index" do
    get firetrees_url
    assert_response :success
  end

  test "should get new" do
    get new_firetree_url
    assert_response :success
  end

  test "should create firetree" do
    assert_difference('Firetree.count') do
      post firetrees_url, params: { firetree: { body: @firetree.body, name: @firetree.name, user_id: @firetree.user_id } }
    end

    assert_redirected_to firetree_url(Firetree.last)
  end

  test "should show firetree" do
    get firetree_url(@firetree)
    assert_response :success
  end

  test "should get edit" do
    get edit_firetree_url(@firetree)
    assert_response :success
  end

  test "should update firetree" do
    patch firetree_url(@firetree), params: { firetree: { body: @firetree.body, name: @firetree.name, user_id: @firetree.user_id } }
    assert_redirected_to firetree_url(@firetree)
  end

  test "should destroy firetree" do
    assert_difference('Firetree.count', -1) do
      delete firetree_url(@firetree)
    end

    assert_redirected_to firetrees_url
  end
end

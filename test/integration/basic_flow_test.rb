require 'test_helper'

class BasicFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "can see the welcome page" do
    get "/"
    assert_select "#slogan", "gruepers"
  end

  test "user can visit locations index" do
    one = locations(:one)
    two = locations(:two)
    sign_in users(:one)

    get locations_path

    assert @response.body.include? one.name
    assert @response.body.include? two.name 
    #assert_select "body", one.name
    #assert_select "body", two.name
    # visit locations_path
    # assert page.has_content?(one.name)
    # assert page.has_content?(two.name)

  end

  test "user can create grupe from location detail" do
    sign_in users(:one)
    location = locations(:one)
  
    get location_path(location)
    #puts @response.body
    
    assert @response.body.include? "Create new Gruupe"
    
    grupe_name = "can create"
    post "/grupes",
    params: { grupe: { name: grupe_name,
                       location_id: "#{location.id}" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert @response.body.include?("Grupe: #{grupe_name}")

    #debugger

    ## doesnt allow react-webpacker to fire
    #assert @response.body.include?(users(:one).display_name)

  end
end

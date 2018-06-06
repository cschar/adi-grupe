require 'test_helper'

class ReactFlowTest < Capybara::Rails::TestCase
  include Devise::Test::IntegrationHelpers

  def setup

    @user_one = users(:one)
    @loc_one = locations :one
    sign_in users(:one)
  end

  test 'locations detail allows grupe creation' do
    visit location_path(@loc_one)
    assert page.has_content?(@loc_one.name)

    click_on "Create new Gruupe" # -> /new
    click_on "Create Grupe"  # -> POST
    assert_current_path grupe_path(Grupe.last)
    assert page.has_content?(Grupe.last.name)
  end

  # React doesnt work here
  
  # test 'grupe detail shows react app' do
  #   g = Grupe.create name: "test",
  #                    location_id: @loc_one.id,
  #                    creator_id: @user_one.id
  #   g.users << @user_one
  #   visit grupe_path(g)
  #   debugger
  #   assert page.has_content?(@user_one.display_name)
  # end

end
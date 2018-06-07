require 'rails_helper'  #uses spec_helper

feature 'home page' do
  scenario 'welcomes the user', :js => true do
    visit '/'
    expect(page).to have_content('gruepers')
  end
end



feature 'react grupe roster' do
  scenario 'creates grupe and is on roster', :js => true do
    
    user = User.first
    sign_in user
    
    visit locations_path
    # fill_in "Username", :with => "jdoe"
    # fill_in "Password", :with => "secret"
    # click_button "Log in"
    g = Grupe.create name: "hey", location_id: Location.first.id,
         creator_id: User.first.id
    g.users << user

    visit grupe_path(g)
    
    expect(page).to have_content(user.display_name)

  end
end

RSpec.describe "react grupe roster", :type => :feature do
  it "displays the Grupe's users in a react app", :js => true do
    
    #TODO  FactoryBot here
    # user = create(:user)
    user = User.first
    
    sign_in user
    
    visit locations_path
    # fill_in "Username", :with => "jdoe"
    # fill_in "Password", :with => "secret"
    # click_button "Log in"
    g = Grupe.create name: "hey", location_id: Location.first.id,
         creator_id: User.first.id
    g.users << user

    visit grupe_path(g)
    
    expect(page).to have_content(user.display_name)
  
    #expect(page).to have_selector(".header .username", :text => "jdoe")
  end
end
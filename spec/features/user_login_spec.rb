require 'rails_helper'

RSpec.feature "Registered user logs in", type: :feature, js: true do

  # SETUP
  before :each do
    User.create!(
      first_name: 'Emma',
      last_name: 'Watts',
      #name: 'Emma Watts',
      email: 'testing@login.com',
      password: 'randomword',
      password_confirmation: 'randomword'
    )
  end
  
  scenario "Login pathway" do
    # ACT
    visit login_path
    
    # Fill in details
    fill_in'email', with:'testing@login.com'
    fill_in'password', with:'randomword'
    
    # Click 
    click_button('Submit')
    
    # DEBUG / VERIFY
    expect(page).to have_content('Signed in as Emma Watts')
    # save_screenshot

  end

end
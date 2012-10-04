require 'spec_helper'

describe "Create", :type => :request do
  describe "first user create" do
  
     it "Try create new user" do
      visit root_path
      within(".navbar-inner") { click_link 'SignUp' }
      within(".new_user") do
        fill_in 'user[login]', :with => 'AlexKoshelapov'
        fill_in 'user[fullname]', :with => 'Sasha'
        fill_in 'user[email]', :with => 'kosh@mail.com'
        fill_in 'user[password]', :with => '123'
        fill_in 'user[password_confirmation]', :with => '123'
        click_button 'Create User'
      end
      visit root_path
      expect(page).to have_content("AlexKoshelapov")
    end
  end
end

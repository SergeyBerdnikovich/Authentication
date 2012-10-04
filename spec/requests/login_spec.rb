require 'spec_helper'

describe "Auhentication", :type => :request do
  describe "first step" do
     before("all") do
      User.create!(:login => 'AlexKoshelapov', :email => "Koshealex@gmail.com", :password => "123", :two_step_auth => true, :fullname => 'Sasha')
      end

    it "Try seek first step by email" do
      visit root_path
      within(".navbar-inner") { click_link 'LogIn' }
      within(".form-horizontal") do
        fill_in 'email_or_login', :with => 'Koshealex@gmail.com'
        fill_in 'password', :with => '121'
        click_button 'Log in'
      end
    end

    it "Try seek first step by incorrect data" do
      visit root_path
      within(".navbar-inner") { click_link 'LogIn' }
      within(".form-horizontal") do
        fill_in 'email_or_login', :with => 'Koshealex@gmail.com'
        fill_in 'password', :with => '123'
        click_button 'Log in'
      end

    end

    it "redirect unlog edit" do
      visit "/edit"
      current_path.should == '/'
    end
    
    it "redirect unlog show" do
      visit "/show"
      current_path.should == '/'
    end

    it "redirect unlog show" do
      visit "/"
      expect(page).to have_selector("spam.brand", :text => 'Stranger')
    end

    it "Try create" do
      visit root_path
      within(".navbar-inner") { click_link 'SignUp' }
      current_path.should == '/Signup'
    end

     it "Try create" do
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

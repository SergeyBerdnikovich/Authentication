require "spec_helper"
require 'capybara/rspec'
describe SessionController do
  describe "first_auth" do
    before("all") do
      User.create!(:login => 'AlexKoshelapov', :email => "Koshealex@gmail.com", :password => "123", :two_step_auth => true, :fullname => 'Sasha')
    end

    it "First auth" do
      user = User.find_by_login('AlexKoshelapov')
      post(:first_auth, :email_or_login => user.login, :password => '123')
      session[:user_id].should_not be nil
    end

    it "Second auth" do
      user = User.find_by_login('AlexKoshelapov')
      code = user.create_code.to_s
      user.activate!(code)
      session[:user_id] = user.id
      post(:second_auth, :code => code)
      user.confirmed.should be true
    end
    
    it "destroy" do
      user = User.find_by_login('AlexKoshelapov')
      code = user.create_code.to_s
      user.activate!(code)
      session[:user_id] = user.id
      get :destroy
      session[:user_id].should be nil
      User.find_by_login('AlexKoshelapov').confirmed.should be(false)
    end
  end
end

require 'spec_helper'
describe User do
  describe "User" do
    before("all") do
      User.create!(:login => 'AlexKoshelapov', :email => "Koshealex@gmail.com", :password => "123", :two_step_auth => true, :fullname => 'Sasha')
      end
 
    it "Authentication by login" do
      user = User.authentication('AlexKoshelapov', '123')
      user.should_not eq nil
    end

    it "Authentication by email" do
      user = User.authentication('Koshealex@gmail.com', '123')
      user.should_not eq nil
    end

    it "create code" do
      user = User.first
      user.create_code.to_s.should match /([\d]){6}/
    end

    it "activated!" do
      user = User.first
      code = user.create_code
      user.activate!(code.to_s)
      user.confirmed.should be(true)
    end

    it "simple_activated!" do
      user = User.first
      user.simple_activate!
      user.confirmed.should be(true)
    end

    it "deactivated!" do
      user = User.first
      user.create_code
      user.activate!(user.activetion_code)
      user.deactivate!
      user.confirmed.should be(false)
    end

  end
end
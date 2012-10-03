require 'spec_helper'
describe User do
  describe "User" do
    before("all") do
      Role.create!(name: "Admin")
      Role.find_by_name('Admin').users.create!(:login => 'AlexKoshelapov', :email => "Koshealex@gmail.com", :password => "123", :two_step_auth => true)
      end
   it "has 1 admin" do
      Admin = Role.find_by_name('Admin').users.all.count
      Admin.should == 1
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
      user = Role.find_by_name('Admin').users.first
      user.create_code.should match /([\d]){6}/
    end

    it "activated!" do
      user = Role.find_by_name('Admin').users.first
      code = user.create_code
      user.activate!(code)
      user.confirmed.should be(true)
    end

    it "deactivated!" do
      user = Role.find_by_name('Admin').users.first
      user.create_code
      user.activate!(user.activetion_code)
      user.deactivate!
      user.confirmed.should be(false)
    end

  end
end
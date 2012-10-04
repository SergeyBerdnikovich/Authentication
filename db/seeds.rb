# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
1.upto(50){|x| User.create!(:login => "User#{x}", :fullname => x.to_s,:email => "email#{x}@mail.com", :password => x, :two_step_auth => true) }
require_relative "../validator/email_validator"
require 'bcrypt'
class User < ActiveRecord::Base

  has_secure_password
  attr_accessible :email, :fullname, :login, :password, :password_confirmation, :two_step_auth

    validates :login, :presence => true,
              :uniqueness => true
    validates :fullname, :presence => true
    validates :email, :presence => true,
              :uniqueness => true,
              :email => true
    validates :password, :confirmation => true



    def self.authentication(email_or_login, password)
      user = find_by_email(email_or_login) || find_by_login(email_or_login)
      if user && user.try(:authenticate, password)
        user
      else
        nil
      end
    end

    def create_code
      random = Random.new
      code = random.rand(100000..999999)
      code_hash = Digest::MD5.hexdigest(code.to_s)
      self.update_attribute(:activetion_code, code_hash)
      time = Time.now
      self.update_attribute(:token_at, time)

      code
    end

    def activate!(code)        
      if (31.seconds.ago < self.updated_at) && (self.activetion_code == Digest::MD5.hexdigest(code))
        self.update_attribute(:confirmed, true)

        true
      else
        nil
      end
    end

    def simple_activate!
      if self.update_attribute(:confirmed, true)
        true
      else 
        nil
      end
    end

    def deactivate!
        self.update_attribute(:confirmed, false)
        self.update_attribute(:activetion_code, nil)
    end
end

module UsersHelper
  def generation_link_to_gravatar(email)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=100"
  end
end

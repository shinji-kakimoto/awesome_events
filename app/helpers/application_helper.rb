module ApplicationHelper
  def url_for_twitter(user)
    "http://twitter.com/#{user.nickname}"
  end
end

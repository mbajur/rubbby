class UserDecorator < Draper::Decorator
  delegate_all

  def avatar_url(size = 40)
    uid = object.services.last.uid
    "https://avatars0.githubusercontent.com/u/#{uid}?v=2&s=#{size}"
  end

end

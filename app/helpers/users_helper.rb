module UsersHelper
  def gravatar_for(url,user)
    image_tag(url, alt: user, class: "gravatar")
  end
end
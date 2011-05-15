module PostsHelper

  def PostsHelper.generate_slug(title)
    title.downcase.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
  end
end

module ApplicationHelper
  def side_bar_contents
    content = ""
    if can? :create, Post
      content = link_to 'New Post', new_post_path
    end
    content_tag :div, :class => "sidebar" do
      raw (
           content +
           content_tag(:p,"Archives: ") +
           content_tag(:p,"May 2011") +
           content_tag(:p,"May 2011")            
           )
    end
  end
end

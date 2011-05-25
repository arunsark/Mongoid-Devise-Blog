module ApplicationHelper
  def side_bar_contents
    content = ""
    if can? :create, Post
      content = link_to 'New Post', new_post_path
    end
    archives = PostsHelper::archives
    render :partial => 'posts/sidebar', :locals => {:archives => archives}
  end
end

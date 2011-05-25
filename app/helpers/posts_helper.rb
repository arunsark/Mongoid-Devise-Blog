module PostsHelper

  def PostsHelper.generate_slug(title)
    title.downcase.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
  end

  def post_update_destroy_links(post)
    options = []
    if can? :update, post
      options << :update
    end
    if can? :destroy, post
      options << :destroy
    end
    render :partial => "posts/update_destroy" , :locals => {:options => options, :post => post}
  end

  def comments_link(post)
    link_to(pluralize(post.comments.size,"Comment"), post_path(post))
  end

  def self.archives
    aggs = Post.count_and_agg_by_month
    archive_links = []
    aggs.each do |v|
      label =  v["month"] + " " + v["year"].truncate.to_s + "("+ v["count"].truncate.to_s + ")"
      month = v["month"]
      year = v["year"].truncate
      archive_links << {:label => label,:month => month, :year => year }
    end
    archive_links
  end
end


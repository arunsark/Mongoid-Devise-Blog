module CommentsHelper

  def comment_update_destroy_links(comment)
    if comment.author && can?(:update,comment) && can?(:delete,comment)
      render :partial => 'comments/update_destroy' , :locals => {:comment => comment}
    end
  end
end

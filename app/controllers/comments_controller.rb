class CommentsController < ApplicationController

    respond_to :html, :js

  
#{
#	comment: {
#		body: 'this is comment',
#		post_id: 7,
#	}
#}

#def create
#	puts "COMMENTS CREATE = #{params.inspect}"
#	@comment = Comment.new params[:comment]
   

    #authorize! :create, @post, message: "You need to be signed up to do that."
 #   if @comment.save
  #    flash[:notice] = "Post was saved."
  #  else
  #    flash[:error] = "There was an error saving the comments. Please Try again."
  #  end
  #  redirect_to posts_show_path, id: params[:comment][:post_id]
  #end

 def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

  #  @comment = current_user.comments.build(post_params[:comment])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    authorize! :create, @comment, message: "You need be signed in to do that."
    if @comment.save
      flash[:notice] = "Comment was created."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render 'posts/show'
    end
 
  end


  

    def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment, message: "You need to own the comment to delete it."

    if @comment.destroy
      flash[:notice] = "Comment was removed."
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end














   def comment_params
       params.require(:comment).permit( :body, :topic_id,  :post_id)

    end
end
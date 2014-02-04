class CommentsController < ApplicationController
  
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
    @comment = current_user.comments.build(post_params)
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


   def post_params
       params.require(:comment).permit( :body, :topic_id,  :post_id)

    end
end
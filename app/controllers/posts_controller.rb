class PostsController < ApplicationController


  def show
     @topic = Topic.find(params[:topic_id]) 
    @post  = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new(user: current_user)
#    puts "COMMENT NEW = #{@comment.inspect}"
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post  = Post.new
    #authorize! :create, Post
    authorize! :create, Post, message: "You need to be a member to create a new post."
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "You need to own the post to edit it."

  end

  
  

  def create
    @topic = Topic.find(params[:topic_id]) 
    @post = current_user.posts.build(post_params)

     @post.topic  = @topic 
    #@post.topic_id = @topic.id


    authorize! :create, @post, message: "You need to be signed up to do that."
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post], notice: "Post was saved successfully."



    else
      flash[:error] = "There was an error saving the post. Please Try again."
      render :new
    end
  end








  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :update, @post, message: "You need to own the post to edit it."

    if @post.update_attributes(post_params)
      redirect_to [@topic, @post], notice: "Post was saved successfully."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
  


 def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    title = @post.title
    authorize! :destroy, @post, message: "You need to own the post to delete it."
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end  

  
  
    def post_params
       params.require(:post).permit(:email, :password, :password_confirmation, :remember_me, :name, :body, :title, :topic_id, :avatar, :provider, :uid)

    end
    
end

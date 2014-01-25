class PostsController < ApplicationController


  def show
     @topic = Topic.find(params[:topic_id]) 
    #@post = Post.find(params[:id])
    @post  = Post.find(params[:id])
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

  
  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :update, @post, message: "You need to own the post to edit it."

    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
  
  def create
    @topic = Topic.find(params[:topic_id]) 
    #@post = Post.new(post_params)
    @post = current_user.post.build(params[:post])
    authorize :create, @post, message: "You need to be signed up to do that."
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please Try again."
      render :new
    end
  end

  
    def post_params
       params.permit(:email, :password, :password_confirmation, :remember_me, :name, :body, :title)

    end
    
end

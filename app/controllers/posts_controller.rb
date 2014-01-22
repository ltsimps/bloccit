class PostsController < ApplicationController
  


  def index
    @posts = Post.all 
  end

  def show
    #@post = Post.find(params[:id])
    @post = Post.find(params[:id])
  end

  def new
    @post  = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
  
  def create
    #@post = Post.new(post_params)
    @post = current_user.post.build(params[:post])
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

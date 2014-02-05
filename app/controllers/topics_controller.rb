class TopicsController < ApplicationController
  def index
    #@topics = Topic.all
     @topics = Topic.paginate(page: params[:page], per_page: 10) # add this line

  end

  def new
    @topic = Topic.new()
    authorize! :create, @topic, message: "You need to be an admin to do that."
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(page: params[:page], per_page: 10) # add this line

    
    #@posts = @topic.posts
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "you need to be an admin to do that."
  end



  def create
    #@topic = Topic.new(params[:topic])
      @topic = Topic.new(post_params)
      authorize! :create, @topic, message: "you need to be an admin to do that"
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def update 
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to own the topic to update it."

     if @topic.update_attributes(post_params)
        redirect_to @topic, notice: "Topic was saved successfully."
      else
        flash[:error] = "Error saving topic. Please try again"
        render :edit
      end
    end


    def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name
    authorize! :destroy, @topic, message: "You need to own the topic to delete it."

    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end


  private

  def post_params
       params.require(:topic).permit(:description, :name, :public, :topic)

    end

end

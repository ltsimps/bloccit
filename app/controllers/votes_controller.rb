class VotesController < ApplicationController
  before_filter :setup
  
   def up_vote
    update_vote(1)
    redirect_to :back
  end

  def down_vote
    update_vote(-1)
    redirect_to :back
  end


  

   private

  def setup
    puts "HELLO, I AM RUNNING SETUP"
    @topic = Topic.find(params[:topic_id])
    puts "Possible posts = #{@topic.post_ids}"
    @post = @topic.posts.find(params[:post_id])
    authorize! :create, Vote, message: "You need to be a user to do that."


    @vote = @post.votes.where(user_id: current_user.id).first
  end


   def update_vote(new_value)
    if @vote # if it exists, update it
      puts "Updating vote: #{@vote.inspect}"
      @vote.update_attribute(:value, new_value)
      #@vote.update_attributes(post_params, new_value)
    else # create it
      puts "Creating vote: post=#{@post.inspect}"
      @vote = current_user.votes.create(value: new_value, post: @post)
    end
  end
end
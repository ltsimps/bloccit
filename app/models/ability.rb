class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new
    # if a member, they can manage their own posts 
    # (or create new ones)

    puts "ABILITY INITIALIZE, role=#{user.role}"

     if user.role? :member
      can :manage, Post, :user_id => user.id
      can :manage, Comment, :user_id => user.id
      can :create, Vote
      can :read, Topic

    end


     # Moderators can delete any post
    if user.role? :moderator
      can :destroy, Post
      can :destroy, Comment
    end

     # Admins can do anything
    if user.role? :admin
      can :manage, :all
    end

    
    can :read, Topic, public: true
    can :read, Post

   

      end
end

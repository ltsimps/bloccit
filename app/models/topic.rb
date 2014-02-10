class Topic < ActiveRecord::Base
#attr_accessible :description, :name, :public
has_many :posts, dependent: :destroy
 scope :visible_to, lambda { |user| user ? scoped : where(public: true) }

# def as_json
# 	{ name: self.name, public: self.public }
# end

end

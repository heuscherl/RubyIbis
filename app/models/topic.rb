# A topic belongs in one forum, but can have many posts and many users.
class Topic < ActiveRecord::Base
	belongs_to :forum
	has_many :posts, :dependent => :destroy  
	belongs_to :user


	accepts_nested_attributes_for :posts


	validates :name, presence: true

	# finds the most recent post in a thread. 
	def edit_or_not(created, updated)
		if created != updated
			return "(Edited at :" + post.updated_at + ")"\
		end
	end 
 	
end

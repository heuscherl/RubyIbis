# a forum belongs to one category, but can have many topics inside. 
class Forum < ActiveRecord::Base
	belongs_to :category
	has_many :topics, :dependent => :destroy 

	validates :name, presence: true

	# finds the most recent post in a thread. 
	def most_recent_post
		topic = Topic.first(:order => 'last_post_at DESC',
			:conditions => ['forum_id = ?', self.id])

		return topic
	end 

	# will eventually be used. 
	def present_post_date
	  distance = Date.today - self.created_at
	  
	  format_for_old_posts = "Posted On:  " + self.created_at.strftime("%m-%d-%Y")
	  format_for_fresh_posts = "Posted " + distance_of_time_in_words_to_now(self.created_at) + " ago"
	  
	  if(distance > 24.days)
	    format_for_old_posts
	  else
	    format_for_fresh_posts
	  end
	end


end

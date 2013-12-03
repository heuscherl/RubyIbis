# A post can be in one topic and with one user. 
class Post < ActiveRecord::Base  
  belongs_to :topic  
  belongs_to :user


  accepts_nested_attributes_for :topic

  validates :content, presence: true # must have content


  	# finds the most recent post in a thread. 

end  
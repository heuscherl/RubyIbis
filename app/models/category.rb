class Category < ActiveRecord::Base

	# A Category can have many forums. When a category is destroyed, so are all its forums.
    has_many :forums, :dependent => :destroy

    # Forum cannot be blank.
    validates :name, presence: true


end
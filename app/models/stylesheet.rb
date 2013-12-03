# can't have an empty code.
class Stylesheet < ActiveRecord::Base
	validates_presence_of :code
end

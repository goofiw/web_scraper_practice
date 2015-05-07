require 'nokogiri'

class Comment

  attr_reader :user, :comment

	def initialize(user,comment)
		@user = user
		@comment = comment
		
	end
  
  def to_s
  	"\n#{@comment.green} \n    #{@user.red}"
  end
end

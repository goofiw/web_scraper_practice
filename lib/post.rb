require 'nokogiri'
require 'pry'
require 'colorize'
require_relative 'comment'
require_relative 'post_scraper'

class MissingItem < StandardError
end


class Post
	include PostScraper

	attr_reader :comments

	def initialize(args)
		begin
	    @comments = args[:comments]
			@title = args[:title]
			@url = args[:url]
			@item_id = args[:item_id]
			@points = args[:points]
		rescue
			raise MissingItem, "Please provide :comments, :title, :url, :item_id, and :points"
		end
	end
  

  def to_s
    str = "#{@title.blue} |||| #{@url.blue} |||| #{@item_id} |||| #{@points.red}"
    @comments.each { |comment| str << comment.to_s }
    str
  end

  # returns a list of comments
	def comments
    @comments
	end
  
  # adds comment to comment list
	def add_comment(comment)
    
    @comments << comment
  end

end


post =  PostScraper.create_from_hackernews('post.html')
post.add_comment(Comment.new("I am the User!!!!", "This is My Comment Phfaosidhfoaudsbyfiabsdfoyabsdfoasbdoyucavsdovasdcasdvk"))
puts post

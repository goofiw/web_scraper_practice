require 'colorize'
require 'nokogiri'
require_relative 'post_scraper'

class NoNokogiriFileProvided < StandardError
end

module PostScraper
class << self  
	def grab_title
    @doc.search('.title > a').map { |span| span.inner_text }.first #nokogiri grab title
	end
     
	def grab_url
    @doc.search('.title > a').map { |link| link['href'] }.first #nokogiri grab url
	end

	def grab_item_id
    @doc.search('center > a').map { |id| id['id'].match(/(\d+)/) }.first #nokogiri grab item id
	end

	def grab_points
    @doc.search('.score').map { |span| span.inner_text }.first#nokogiri grab score
	end

	def grab_comments_arr
    @doc.search('.comment').map { |comment| comment.inner_text }
	end

	def grab_user_arr
    @doc.search('.comhead > a:first-child').map { |user| user.inner_text }
	end

	def load_comments
    comment = grab_comments_arr
	  user = grab_user_arr
	  comments = []
	  user.each_with_index { |user, idx| comments << Comment.new(user, comment[idx]) }	
	  comments			
  end
end
  def self.create_from_hackernews(doc)
  	raise NoNokogiriFileProvided, "convert file to nokogiri" if !File.file?(doc)
    @doc = Nokogiri::HTML(File.open(doc))
    Post.new({comments: load_comments,
    	       title: grab_title,
    	       url: grab_url,
    	       item_id: grab_item_id,
    	       points: grab_points})
  end

end 



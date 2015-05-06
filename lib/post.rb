require 'nokogiri'
require 'pry'

class Post

	def initialize(doc)
    @comments = []
		@title = doc.search('.title > a').map { |span| span.inner_text } #nokogiri grab title
		@url = doc.search('.title > a').map { |link| link['href'] } #nokogiri grab url
		@item_id = doc.search('center:first-child > a').map { |id| id['id'].match(/w+/) } #nokogiri grab points
		@points = doc.search('.score').map { |span| span.inner_text.match(/\w+/) }#nokogiri grab item_id
	end
  
  # returns a list of comments
	def comments
    @comments
		
	end
  
  # adds comment to comment list
	def add_comment(comment, args)
    
    @comments[get_comment_idx(args)] #<< comment
  end

  private
  def get_comment_idx(args)
  	binding.pry
  	return @item_id.find_index(args[:id]) if args[:id] != nil
  end

end


Post.new(Nokogiri::HTML(File.open('front_page.html'))).add_comment("fasdf",id:"9500066")
require_relative 'comment'
require_relative 'post'
require_relative 'post_scraper'

post =  PostScraper.create_from_hackernews('post.html')
post.add_comment(Comment.new("I am the User!!!!", "This is My Comment Phfaosidhfoaudsbyfiabsdfoyabsdfoasbdoyucavsdovasdcasdvk"))
puts post
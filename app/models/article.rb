class Article < ActiveRecord::Base
	belongs_to :user

	validates :user_id, presence: true
	validates :content, presence: true

	before_save :count_article_words




	private
		def count_article_words

	 		self.estimated_time = (ActionView::Base.full_sanitizer.sanitize(self.content).scan(/\w+/).size)/3
			
		end
end

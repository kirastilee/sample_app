module ApplicationHelper
	def full_title page_title=""
		base_title = "ruby on rails tutorial sample app"
		title = page_title.empty? ? base_title : "#{page_title} | #{base_tital}"
		return title
	end
end

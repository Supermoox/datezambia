module ApplicationHelper
	def googlemap_frame(url)
		content_tag(:iframe, '', src: url, width: 300, height: 250, frameborder: 0)
	end
end

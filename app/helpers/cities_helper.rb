module CitiesHelper
	def googlemap_frame(url)
		content_tag(:iframe, '', src: url, width: 200, height: 250, frameborder: 0)
	end
end
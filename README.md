def index
		if params[:content]
			@results = []
			@search = params[:content]

			 Listing.where("product_name iLIKE (?)", "%#{params[:content]}%").each do |x|
				@results << x
			 end

			@tags = Tag.where("description iLIKE (?)", "%#{params[:content]}%")
			


			@tags.each do |tag| 
				tag.listings.each do |listing|
					byebug
					@results << listing if @results.include?(listing) == false
				end
			end
			# @listings.uniq!
		else
			@listings = Listing.all
		end

		@page = params[:page] || 0
		@page = @page.to_i
		@page_limit = (@listings.count / 10)
		if @page < 0
			@page = 0
		elsif @page > @page_limit
			@page = @page_limit
		end

		unless Listing.count <= 10
			offset = @page*10
			@listings = @listings.limit(10).offset(offset)
		end
		
		# @listings = @listings.order("price, product_name")
	end
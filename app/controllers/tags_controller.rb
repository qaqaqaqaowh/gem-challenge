class TagsController < ApplicationController
	def new
		@listing = Listing.find(params[:format])
		@tags = Tag.new
	end

	def create
		@listing = Listing.find(params[:id])
		@tags = params[:tag][:description]
		@tags = @tags.split(" ")
		@tags.map!{|tag|
			Tag.find_or_create_by(description: tag)
		}
		@listing.tags << @tags
		redirect_to listing_path(@listing)
	end

	def destroy
		@tag = Tag.find(params[:id])
		@listing = Listing.find(params[:listing_id])
		@listing.tags.delete(@tag)
		redirect_to listing_path(params[:listing_id])
	end
end

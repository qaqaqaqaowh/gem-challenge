class ListingsController < ApplicationController

	def index
		if params[:content]
			@search = params[:content]
			@listings = Listing.where("product_name iLIKE (?)", "%#{params[:content]}%")
			@tags = Tag.where("description iLIKE (?)", "%#{params[:content]}%")
			@tags.each{ |tag| @listings += tag.listings }
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
		@listings = @listings.uniq
		@listings = @listings.sort_by{|x| [x.product_name.downcase, x.price]}
	end

	def new
		@listing = Listing.new
	end

	def show
		@listing = Listing.find(params[:id])
		@tags = @listing.tags
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if params[:listing][:tags]
			@tags = params[:listing][:tags]
			@tags = @tags.split(" ")
			@tags.map!{|tag|
				Tag.find_or_create_by(description: tag)
			}
		end
		@listing.tags << @tags
		@listing.save
		redirect_to listings_path
	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(listing_params)
		redirect_to listing_path(@listing)
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_path
	end

	private
	def listing_params
		params.require(:listing).permit(:product_name, :price, {avatars: []})
	end
end
class ItemsController < ApplicationController

	def new
		@brand = Brand.find(params[:brand_id])
		@item = @brand.items.build
	end

	def create
		@brand = Brand.find(params[:brand_id])
		@item = @brand.items.build(item_params)
		@item.save
		flash[:success] = "The item was added to the brand"
		redirect_to @brand
	end

	private

		def item_params
			params.require(:item).permit(:name, :number)
		end
end

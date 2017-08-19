class BrandsController < ApplicationController

	def new
		@brand = Brand.new
	end

	def create 
		@brand = Brand.new(brand_params)
		if @brand.save
			flash[:success] = "The brand has been added"
			redirect_to company_path(@brand.company)
		else
			flash.now[:warning] = "The brand was not added"
			render 'new'
		end
	end

	private

		def brand_params
			params.require(:brand).permit(:name, :prefix, :company_id)
		end
end

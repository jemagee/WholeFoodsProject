class BrandsController < ApplicationController

	before_action :get_brand, only: [:show, :edit, :update, :destroy]

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

	def show
	end

	def edit
	end

	def update
		if @brand.update(brand_params)
			flash[:success] = "The brand was updated"
			redirect_to company_path(@brand.company)
		else
			flash.now[:warning] = "The brand was not updated"
			render 'edit'
		end
	end

	private

		def brand_params
			params.require(:brand).permit(:name, :prefix, :company_id)
		end

		def get_brand
			@brand = Brand.find(params[:id])
		end
end

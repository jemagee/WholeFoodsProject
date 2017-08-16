class StoresController < ApplicationController

	def new
		@store = Store.new
	end

	def create 
		@store = Store.new(store_params)
		if @store.save
			flash[:success] = "The store was added"
			redirect_to @store
		else
			flash[:warning] = "The store was not entered"
			render 'new'
		end
	end

	def show
		@store = Store.find(params[:id])
	end

	private

		def store_params
			params.require(:store).permit(:name, :number, :region_id)
		end
end

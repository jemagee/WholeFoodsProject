class StoresController < ApplicationController

	before_action :get_store, only: [:edit, :show, :update, :destroy]

	def index
		@stores = Store.open
	end

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
	end

	def edit
	end

	def update
		if @store.update(store_params)
			flash[:success] = "The store was updated"
			redirect_to @store
		else
			flash.now[:warning] = "The store was not updated"
			render 'edit'
		end
	end

	def destroy
		@store.open = false
		@store.save
		flash[:success] = "The store was successfully archived"
		redirect_to stores_path
	end

	private

		def store_params
			params.require(:store).permit(:name, :number, :region_id)
		end

		def get_store
			@store = Store.find(params[:id])
		end
end

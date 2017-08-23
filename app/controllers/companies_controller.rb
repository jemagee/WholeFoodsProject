class CompaniesController < ApplicationController

	before_action :get_company, only: [:edit, :show, :update, :destroy, :addbrand]

	def index
		@companies = Company.all
	end

	def new
		@company = Company.new
	end

	def create
		@company = Company.new(company_params)
		if @company.save
			flash[:success] = "The company was added to the database"
			redirect_to companies_path
		else
			flash.now[:warning] = "The company was not added to the database"
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def addbrand
		if @company.update_attributes(company_params)
			flash[:success] = "The brand was added to the company"
			redirect_to @company
		else
			flash[:warning] = "The brand was not added to the company"
			render template: 'companies/show'
		end
	end
	def update
		if @company.update_attributes(company_params)
			flash[:success] = "The company was updated"
			redirect_to @company
		else
			flash.now[:warning] = "The company was not updated"
			render 'edit'
		end
	end

	def destroy
		@company.destroy
		flash[:success] = "The company has been deleted"
		redirect_to companies_path
	end


	private 

		def company_params
			params.require(:company).permit(:name, brands_attributes: [:id, :name, :prefix])
		end

		def get_company
			@company = Company.find(params[:id])
		end
end
